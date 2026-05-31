import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/audit_log.dart';
import '../models/user_info.dart';
import '../services/admin_service.dart';
import '../services/auth_service.dart';
import '../utils/snackbar_utils.dart';
import '../widgets/streaming/role_badge.dart';
import '../widgets/streaming/streaming_search_field.dart';

/// Tela administrativa para gerenciamento de papéis, ativação de usuários e visualização de logs de auditoria.
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AdminService _adminService = AdminService();

  List<UserInfo> _users = [];
  List<UserInfo> _filteredUsers = [];
  List<AuditLog> _logs = [];

  bool _isLoadingUsers = false;
  bool _isLoadingLogs = false;

  String _userSearchQuery = '';

  String? _selectedTable;
  DateTimeRange? _selectedDateRange;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregar os dados após a primeira renderização para garantir segurança de acesso
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthService>().isAdmin) {
        _loadUsers();
        _loadLogs();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    if (!mounted) return;
    setState(() {
      _isLoadingUsers = true;
    });
    try {
      final users = await _adminService.fetchAllUsers();
      if (!mounted) return;
      setState(() {
        _users = users;
        _filterUsers();
        _isLoadingUsers = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingUsers = false;
      });
      SnackbarUtils.show(
        context,
        message: 'Erro ao carregar usuários: $e',
        isError: true,
      );
    }
  }

  Future<void> _loadLogs() async {
    if (!mounted) return;
    setState(() {
      _isLoadingLogs = true;
    });
    try {
      final logs = await _adminService.fetchAuditLogs(
        tableName: _selectedTable,
        startDate: _selectedDateRange?.start,
        endDate: _selectedDateRange?.end,
      );
      if (!mounted) return;
      setState(() {
        _logs = logs;
        _isLoadingLogs = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingLogs = false;
      });
      SnackbarUtils.show(
        context,
        message: 'Erro ao carregar logs: $e',
        isError: true,
      );
    }
  }

  void _filterUsers() {
    if (_userSearchQuery.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users.where((user) {
        return user.email.toLowerCase().contains(_userSearchQuery.toLowerCase());
      }).toList();
    }
  }

  Future<void> _updateUserRole(UserInfo user, String newRole) async {
    try {
      await _adminService.updateUserRole(user.id, newRole);
      final dummyUser = UserInfo(id: '', email: '', role: newRole);
      if (!mounted) return;
      SnackbarUtils.show(
        context,
        message: 'Papel de ${user.email} atualizado para ${dummyUser.roleLabel}!',
      );
      _loadUsers();
    } catch (e) {
      if (!mounted) return;
      SnackbarUtils.show(
        context,
        message: 'Erro ao alterar papel: $e',
        isError: true,
      );
    }
  }

  Future<void> _toggleUserActive(UserInfo user) async {
    final newActiveState = !user.isActive;
    final actionText = newActiveState ? 'ativar' : 'desativar';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirmar Ação',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Tem certeza que deseja $actionText o usuário com o e-mail ${user.email}?',
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(newActiveState ? 'Ativar' : 'Desativar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _adminService.setUserActive(user.id, newActiveState);
        if (!mounted) return;
        SnackbarUtils.show(
          context,
          message: 'Usuário ${user.email} ${newActiveState ? 'ativado' : 'desativado'} com sucesso!',
        );
        _loadUsers();
      } catch (e) {
        if (!mounted) return;
        SnackbarUtils.show(
          context,
          message: 'Erro ao alterar status: $e',
          isError: true,
        );
      }
    }
  }

  Future<void> _selectDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      locale: const Locale('pt', 'BR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  surface: Theme.of(context).colorScheme.surface,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          child: child!,
        );
      },
    );

    if (range != null) {
      setState(() {
        _selectedDateRange = range;
      });
      _loadLogs();
    }
  }

  String _formatJson(Map<String, dynamic>? data) {
    if (data == null) return 'Nenhum dado';
    final cleaned = Map<String, dynamic>.from(data)
      ..remove('is_synced')
      ..remove('is_deleted');

    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(cleaned);
  }

  void _showLogDetails(AuditLog log) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(log.createdAt);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Detalhes do Log',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Ação:', log.actionLabel, colorScheme),
                _buildDetailRow('Tabela:', log.tableLabel, colorScheme),
                _buildDetailRow('ID do Registro:', log.recordId, colorScheme),
                _buildDetailRow('Nome Registro:', log.recordName, colorScheme),
                _buildDetailRow('Executor:', log.userEmail ?? 'Desconhecido', colorScheme),
                _buildDetailRow('Data/Hora:', dateStr, colorScheme),
                const SizedBox(height: 16),
                if (log.oldData != null && log.oldData!.isNotEmpty) ...[
                  Text(
                    'Dados Anteriores:',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.error.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      _formatJson(log.oldData),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (log.newData != null && log.newData!.isNotEmpty) ...[
                  Text(
                    'Novos Dados:',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      _formatJson(log.newData),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13, color: colorScheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(String action, ColorScheme colorScheme) {
    IconData icon;
    Color color;

    switch (action) {
      case 'INSERT':
        icon = Icons.add_circle;
        color = colorScheme.primary;
        break;
      case 'UPDATE':
        icon = Icons.edit;
        color = colorScheme.tertiary;
        break;
      case 'DELETE':
        icon = Icons.delete_outline;
        color = colorScheme.error;
        break;
      default:
        icon = Icons.info_outline;
        color = colorScheme.outline;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildAccessDeniedScreen(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Acesso Negado",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.gpp_bad_outlined,
                size: 80,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                "Área Restrita",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Esta área é destinada exclusivamente a administradores do sistema.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final colorScheme = Theme.of(context).colorScheme;

    // G-09: Verificação rigorosa de acesso
    if (!authService.isAdmin) {
      return _buildAccessDeniedScreen(context);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Painel do Administrador",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 13),
            tabs: const [
              Tab(
                icon: Icon(Icons.people_outline),
                text: "Usuários",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "Auditoria",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ABA USUÁRIOS
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StreamingSearchField(
                    controller: _searchController,
                    hintText: 'Buscar usuário por e-mail...',
                    onChanged: (val) {
                      setState(() {
                        _userSearchQuery = val;
                        _filterUsers();
                      });
                    },
                    onClear: () {
                      _searchController.clear();
                      setState(() {
                        _userSearchQuery = '';
                        _filterUsers();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadUsers,
                    child: _isLoadingUsers
                        ? const Center(child: CircularProgressIndicator())
                        : _filteredUsers.isEmpty
                            ? ListView(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.4,
                                    child: Center(
                                      child: Text(
                                        "Nenhum usuário encontrado.",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colorScheme.outline),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: _filteredUsers.length,
                                separatorBuilder: (_, index) => Divider(
                                  height: 1,
                                  color: colorScheme.outline.withValues(alpha: 0.1),
                                ),
                                itemBuilder: (context, index) {
                                  final user = _filteredUsers[index];
                                  return Opacity(
                                    opacity: user.isActive ? 1.0 : 0.5,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                      leading: CircleAvatar(
                                        backgroundColor: colorScheme.primaryContainer,
                                        backgroundImage: user.avatarUrl != null
                                            ? NetworkImage(user.avatarUrl!)
                                            : null,
                                        child: user.avatarUrl == null
                                            ? Icon(Icons.person, color: colorScheme.primary)
                                            : null,
                                      ),
                                      title: Text(
                                        user.email,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          decoration: user.isActive
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: RoleBadge(
                                              role: user.role,
                                              label: user.roleLabel,
                                              isActive: user.isActive,
                                            ),
                                          ),
                                          if (!user.isActive) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              margin: const EdgeInsets.only(top: 6),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: colorScheme.outline.withValues(alpha: 0.15),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Inativo",
                                                style: TextStyle(
                                                  color: colorScheme.outline,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      trailing: PopupMenuButton<String>(
                                        onSelected: (val) {
                                          if (val == 'active_toggle') {
                                            _toggleUserActive(user);
                                          } else {
                                            _updateUserRole(user, val);
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'user',
                                            child: Text('Definir como Usuário'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'moderator',
                                            child: Text('Definir como Moderador'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'admin',
                                            child: Text('Definir como Administrador'),
                                          ),
                                          const PopupMenuDivider(),
                                          PopupMenuItem(
                                            value: 'active_toggle',
                                            child: Text(user.isActive ? 'Desativar' : 'Ativar'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),

            // ABA AUDITORIA (LOGS)
            Column(
              children: [
                // Filtros de Auditoria
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              key: ValueKey(_selectedTable),
                              initialValue: _selectedTable,
                              decoration: InputDecoration(
                                labelText: 'Filtrar por Tabela',
                                labelStyle: Theme.of(context).textTheme.bodyMedium!,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: null, child: Text('Todas as Tabelas')),
                                DropdownMenuItem(value: 'categories', child: Text('Categorias')),
                                DropdownMenuItem(value: 'lyrics', child: Text('Letras')),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  _selectedTable = val;
                                });
                                _loadLogs();
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton.filledTonal(
                            icon: Icon(
                              Icons.calendar_month,
                              color: _selectedDateRange != null ? colorScheme.primary : null,
                            ),
                            tooltip: 'Selecionar Período',
                            onPressed: _selectDateRange,
                          ),
                        ],
                      ),
                      if (_selectedTable != null || _selectedDateRange != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _selectedDateRange != null
                                    ? 'Período: ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}'
                                    : 'Todas as datas',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 13,
                                  color: colorScheme.outline,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selectedTable = null;
                                  _selectedDateRange = null;
                                });
                                _loadLogs();
                              },
                              icon: const Icon(Icons.clear, size: 16),
                              label: const Text('Limpar Filtros'),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Lista de Logs
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadLogs,
                    child: _isLoadingLogs
                        ? const Center(child: CircularProgressIndicator())
                        : _logs.isEmpty
                            ? ListView(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.4,
                                    child: Center(
                                      child: Text(
                                        "Nenhum log encontrado.",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colorScheme.outline),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                itemCount: _logs.length,
                                separatorBuilder: (_, index) => Divider(
                                  height: 1,
                                  color: colorScheme.outline.withValues(alpha: 0.1),
                                ),
                                itemBuilder: (context, index) {
                                  final log = _logs[index];
                                  final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(log.createdAt);
                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                                    leading: _buildActionIcon(log.action, colorScheme),
                                    title: Text(
                                      '${log.actionLabel} de ${log.tableLabel}',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${log.recordName} • ${log.userEmail ?? "Desconhecido"}\n$dateStr',
                                      style: Theme.of(context).textTheme.bodySmall!,
                                    ),
                                    trailing: const Icon(Icons.chevron_right),
                                    onTap: () => _showLogDetails(log),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
