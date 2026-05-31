import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Serviço de autenticação com suporte a sessão anônima e login Google.
///
/// Cria automaticamente uma sessão anônima se não houver usuário logado,
/// permitindo que os dados sejam vinculados ao dispositivo.
class AuthService extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  // Google Sign In - API v7
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

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
  bool _isActive = true;
  String get userRole => _userRole;
  bool get isActive => _isActive;

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
    try {
      await _googleSignIn.initialize(
        serverClientId:
            '971288561592-7422rneb4iv0ptem2hdlvsmd96pfsfi0.apps.googleusercontent.com',
      );
    } catch (e) {
      debugPrint('[AuthService] Error initializing GoogleSignIn: $e');
    }

    _client.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      debugPrint('[AuthService] Auth event: $event');

      _currentUser = session?.user;

      // Buscar role do usuário quando logar
      if (_currentUser != null && !(_currentUser!.isAnonymous)) {
        final active = await _fetchUserRole();
        if (!active) {
          await signOut();
          _error = 'Sua conta está desativada. Entre em contato com o administrador.';
          notifyListeners();
          return;
        }
        _subscribeToRoleChanges();
      } else {
        _userRole = 'user';
        _isActive = true;
      }

      notifyListeners();

      if (event == AuthChangeEvent.signedOut) {
        debugPrint('[AuthService] User signed out');
        _userRole = 'user';
        _isActive = true;
        _unsubscribeFromRoleChanges();
      }
    });

    final session = _client.auth.currentSession;
    _currentUser = session?.user;

    if (_currentUser != null && !(_currentUser!.isAnonymous)) {
      final active = await _fetchUserRole();
      if (!active) {
        await signOut();
        _error = 'Sua conta está desativada. Entre em contato com o administrador.';
      } else {
        _subscribeToRoleChanges();
      }
    }

    _isInitialized = true;
    notifyListeners();

    debugPrint(
      '[AuthService] Initialized. User: ${_currentUser?.id ?? "none"}, Role: $_userRole',
    );
  }

  /// Busca role e status ativo. Retorna false se conta desativada.
  Future<bool> _fetchUserRole() async {
    try {
      final response = await _client
          .from('user_roles')
          .select('role, is_active')
          .eq('id', _currentUser!.id)
          .maybeSingle();

      if (response != null) {
        _userRole = response['role'] as String;
        _isActive = response['is_active'] as bool? ?? true;
        debugPrint('[AuthService] User role: $_userRole, active: $_isActive');
        return _isActive;
      }

      _userRole = 'user';
      _isActive = true;
      await _createUserRole();
      return true;
    } catch (e) {
      debugPrint('[AuthService] Error fetching role: $e');
      _userRole = 'user';
      _isActive = true;
      return true;
    }
  }

  Future<bool> _ensureUserIsActive() async {
    if (_currentUser == null || _currentUser!.isAnonymous) return true;
    final active = await _fetchUserRole();
    if (!active) {
      _error = 'Sua conta está desativada. Entre em contato com o administrador.';
      await signOut();
      notifyListeners();
    }
    return active;
  }

  /// Cria registro de role para novo usuário
  Future<void> _createUserRole() async {
    try {
      await _client.from('user_roles').insert({
        'id': _currentUser!.id,
        'email': _currentUser!.email ?? '',
        'role': 'user',
        'avatar_url': _currentUser!.userMetadata?['avatar_url'],
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
            final newActive = payload.newRecord['is_active'] as bool? ?? true;
            final roleChanged = _userRole != newRole;
            final activeChanged = _isActive != newActive;
            if (roleChanged) {
              _userRole = newRole;
              debugPrint('[AuthService] Role updated to: $_userRole');
            }
            if (activeChanged) {
              _isActive = newActive;
            }
            if (roleChanged || activeChanged) {
              notifyListeners();
            }
            if (!_isActive) {
              _error =
                  'Sua conta foi desativada. Entre em contato com o administrador.';
              signOut();
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

      // API v7 - authenticate() retorna GoogleSignInAccount
      final googleUser = await _googleSignIn.authenticate();

      debugPrint('[AuthService] Google user: ${googleUser.email}');

      // Obter tokens de autenticação
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

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
      );

      if (response.user != null) {
        _currentUser = response.user;
        debugPrint(
          '[AuthService] Google login successful: ${_currentUser!.email}',
        );
        if (!await _ensureUserIsActive()) {
          return false;
        }
        return true;
      }

      _error = 'Falha ao autenticar com Google';
      return false;
    } catch (e) {
      debugPrint('[AuthService] Google Sign In error: $e');
      if (e is PlatformException && e.code == 'sign_in_failed') {
        final message = e.message ?? '';
        if (message.contains('ApiException: 10')) {
          _error =
              'Falha no login Google (ApiException: 10). Isso normalmente indica configuração incorreta: package name/SHA-1/SHA-256 do app não conferem com o OAuth Client, ou o serverClientId (Web Client ID) não é do mesmo projeto.';
        } else {
          _error = 'Falha no login Google: $message';
        }
      } else {
        _error = 'Erro ao fazer login: ${e.toString()}';
      }
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
