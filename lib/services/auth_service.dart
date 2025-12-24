import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Serviço de autenticação com suporte a sessão anônima e login Google.
///
/// Cria automaticamente uma sessão anônima se não houver usuário logado,
/// permitindo que os dados sejam vinculados ao dispositivo.
class AuthService extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  // Google Sign In - API v6
  // serverClientId é o Web Client ID necessário para obter o idToken
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId:
        '971288561592-7422rneb4iv0ptem2hdlvsmd96pfsfi0.apps.googleusercontent.com',
  );

  User? _currentUser;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _error;
  RealtimeChannel? _roleSubscription;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  // Retorna true se não há usuário OU se o usuário é anônimo
  bool get isAnonymous =>
      _currentUser == null || (_currentUser?.isAnonymous ?? true);
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get userId => _currentUser?.id;
  String? get userEmail => _currentUser?.email;
  String? get displayName =>
      _currentUser?.userMetadata?['full_name'] as String?;
  String? get photoUrl => _currentUser?.userMetadata?['avatar_url'] as String?;

  // Sistema de Roles
  String _userRole = 'user';
  String get userRole => _userRole;

  // Verificadores de permissão
  bool get canAddLyrics => !isAnonymous && hasRole('user');
  bool get canEditLyrics => !isAnonymous && hasRole('moderator');
  bool get canDeleteLyrics => !isAnonymous && hasRole('admin');
  bool get canAddCategories => !isAnonymous && hasRole('moderator');
  bool get canEditCategories => !isAnonymous && hasRole('moderator');
  bool get canDeleteCategories => !isAnonymous && hasRole('admin');
  bool get isAdmin => hasRole('admin');
  bool get isModerator => hasRole('moderator');

  bool hasRole(String requiredRole) {
    if (requiredRole == 'user') {
      return _userRole == 'user' ||
          _userRole == 'moderator' ||
          _userRole == 'admin';
    } else if (requiredRole == 'moderator') {
      return _userRole == 'moderator' || _userRole == 'admin';
    } else if (requiredRole == 'admin') {
      return _userRole == 'admin';
    }
    return false;
  }

  /// Recarrega a role do usuário do banco de dados
  Future<void> refreshUserRole() => _fetchUserRole();

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    _client.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      debugPrint('[AuthService] Auth event: $event');

      _currentUser = session?.user;

      // Buscar role do usuário quando logar
      if (_currentUser != null && !(_currentUser!.isAnonymous)) {
        await _fetchUserRole();
        _subscribeToRoleChanges();
      } else {
        _userRole = 'user';
      }

      notifyListeners();

      if (event == AuthChangeEvent.signedOut) {
        debugPrint('[AuthService] User signed out');
        _userRole = 'user';
        _unsubscribeFromRoleChanges();
      }
    });

    final session = _client.auth.currentSession;
    _currentUser = session?.user;

    if (_currentUser != null && !(_currentUser!.isAnonymous)) {
      await _fetchUserRole();
      _subscribeToRoleChanges();
    }

    _isInitialized = true;
    notifyListeners();

    debugPrint(
      '[AuthService] Initialized. User: ${_currentUser?.id ?? "none"}, Role: $_userRole',
    );
  }

  /// Busca a role do usuário no banco de dados
  Future<void> _fetchUserRole() async {
    try {
      final response = await _client
          .from('user_roles')
          .select('role')
          .eq('id', _currentUser!.id)
          .maybeSingle();

      if (response != null) {
        _userRole = response['role'] as String;
        debugPrint('[AuthService] User role: $_userRole');
      } else {
        // Usuário novo, criar registro com role padrão
        _userRole = 'user';
        await _createUserRole();
      }
    } catch (e) {
      debugPrint('[AuthService] Error fetching role: $e');
      _userRole = 'user';
    }
  }

  /// Cria registro de role para novo usuário
  Future<void> _createUserRole() async {
    try {
      await _client.from('user_roles').insert({
        'id': _currentUser!.id,
        'email': _currentUser!.email ?? '',
        'role': 'user',
      });
      debugPrint('[AuthService] Created user role for ${_currentUser!.email}');
    } catch (e) {
      debugPrint('[AuthService] Error creating role: $e');
    }
  }

  /// Garante que há uma sessão ativa (anônima se necessário).
  Future<void> _subscribeToRoleChanges() async {
    if (_currentUser == null || _roleSubscription != null) return;

    debugPrint(
      '[AuthService] Subscribing to role changes for ${_currentUser!.id}',
    );

    _roleSubscription = _client
        .channel('public:user_roles:${_currentUser!.id}')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'user_roles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: _currentUser!.id,
          ),
          callback: (payload) {
            debugPrint(
              '[AuthService] Role change detected: ${payload.newRecord}',
            );
            final newRole = payload.newRecord['role'] as String;
            if (_userRole != newRole) {
              _userRole = newRole;
              debugPrint('[AuthService] Role updated to: $_userRole');
              notifyListeners();
            }
          },
        )
        .subscribe();
  }

  void _unsubscribeFromRoleChanges() {
    if (_roleSubscription != null) {
      debugPrint('[AuthService] Unsubscribing from role changes');
      _client.removeChannel(_roleSubscription!);
      _roleSubscription = null;
    }
  }

  /// Garante que há uma sessão ativa (anônima se necessário).
  Future<bool> ensureAuthenticated() async {
    if (_isLoading) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_currentUser != null) {
        debugPrint('[AuthService] Already authenticated: ${_currentUser!.id}');
        return true;
      }

      final session = _client.auth.currentSession;
      if (session != null) {
        _currentUser = session.user;
        debugPrint('[AuthService] Recovered session: ${_currentUser!.id}');
        return true;
      }

      debugPrint('[AuthService] Creating anonymous session...');
      final response = await _client.auth.signInAnonymously();

      if (response.user != null) {
        _currentUser = response.user;
        debugPrint(
          '[AuthService] Anonymous session created: ${_currentUser!.id}',
        );
        return true;
      }

      _error = 'Falha ao criar sessão';
      return false;
    } catch (e) {
      debugPrint('[AuthService] Error: $e');
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login com Google (opcional - pode ser usado a qualquer momento)
  Future<bool> signInWithGoogle() async {
    if (_isLoading) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      debugPrint('[AuthService] Starting Google Sign In...');

      // API v6 - signIn() retorna GoogleSignInAccount
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('[AuthService] Google Sign In cancelled');
        _error = 'Login cancelado';
        return false;
      }

      debugPrint('[AuthService] Google user: ${googleUser.email}');

      // Obter tokens de autenticação
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        _error = 'Não foi possível obter token do Google';
        debugPrint('[AuthService] No idToken received');
        return false;
      }

      debugPrint('[AuthService] Got Google tokens, signing in to Supabase...');

      // Autenticar com Supabase usando o token do Google
      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        _currentUser = response.user;
        debugPrint(
          '[AuthService] Google login successful: ${_currentUser!.email}',
        );
        return true;
      }

      _error = 'Falha ao autenticar com Google';
      return false;
    } catch (e) {
      debugPrint('[AuthService] Google Sign In error: $e');
      _error = 'Erro ao fazer login: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Faz logout do usuário atual.
  Future<void> signOut() async {
    try {
      // Tenta deslogar do Google (pode falhar se nunca foi logado)
      try {
        await _googleSignIn.signOut();
      } catch (e) {
        // Ignora erro se Google Sign In nunca foi inicializado
        debugPrint('[AuthService] Google signOut skipped: $e');
      }

      // Desloga do Supabase
      await _client.auth.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      debugPrint('[AuthService] Sign out error: $e');
    }
  }

  /// Atualiza para conta com email (upgrade de anônimo).
  Future<bool> upgradeToEmail(String email, String password) async {
    if (_currentUser == null || !_currentUser!.isAnonymous) {
      return false;
    }

    try {
      final response = await _client.auth.updateUser(
        UserAttributes(email: email, password: password),
      );

      if (response.user != null) {
        _currentUser = response.user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[AuthService] Upgrade error: $e');
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
