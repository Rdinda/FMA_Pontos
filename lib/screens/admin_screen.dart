import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_info.dart';
import '../models/audit_log.dart';
import '../services/admin_service.dart';
import '../utils/snackbar_utils.dart';

/// Tela administrativa para gerenciamento de usuários e logs.
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AdminService _adminService = AdminService();

  // Estado de usuários
  List<UserInfo> _users = [];
  bool _loadingUsers = true;
  String _userSearchQuery = '';
  final TextEditingController _userSearchController = TextEditingController();

  // Estado de logs
  List<AuditLog> _logs = [];
  bool _loadingLogs = true;
  String? _selectedTable;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUsers();
    _loadLogs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _loadingUsers = true);
    try {
      final users = await _adminService.fetchAllUsers();
      setState(() {
        _users = users;
        _loadingUsers = false;
      });
    } catch (e) {
      setState(() => _loadingUsers = false);
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Erro ao carregar usuários: $e',
          isError: true,
        );
      }
    }
  }

  Future<void> _loadLogs() async {
    setState(() => _loadingLogs = true);
    try {
      final logs = await _adminService.fetchAuditLogs(
        tableName: _selectedTable,
        startDate: _startDate,
        endDate: _endDate,
      );
      setState(() {
        _logs = logs;
        _loadingLogs = false;
      });
    } catch (e) {
      setState(() => _loadingLogs = false);
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Erro ao carregar logs: $e',
          isError: true,
        );
      }
    }
  }

  Future<void> _updateUserRole(UserInfo user, String newRole) async {
    try {
      await _adminService.updateUserRole(user.id, newRole);
      await _loadUsers();
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Role atualizada para ${user.email}',
        );
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Erro ao atualizar role: $e',
          isError: true,
        );
      }
    }
  }

  Future<void> _toggleUserActive(UserInfo user) async {
    final newStatus = !user.isActive;
    final action = newStatus ? 'ativar' : 'desativar';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${newStatus ? 'Ativar' : 'Desativar'} usuário'),
        content: Text('Deseja $action o usuário ${user.email}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(newStatus ? 'Ativar' : 'Desativar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _adminService.setUserActive(user.id, newStatus);
        await _loadUsers();
        if (mounted) {
          SnackbarUtils.show(
            context,
            message: 'Usuário ${newStatus ? 'ativado' : 'desativado'}',
          );
        }
      } catch (e) {
        if (mounted) {
          SnackbarUtils.show(context, message: 'Erro: $e', isError: true);
        }
      }
    }
  }

  void _showLogDetails(AuditLog log) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${log.actionLabel} - ${log.tableLabel}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID do Registro', log.recordId),
              _buildDetailRow('Nome', log.recordName),
              _buildDetailRow('Usuário', log.userEmail ?? 'Desconhecido'),
              _buildDetailRow(
                'Data',
                DateFormat('dd/MM/yyyy HH:mm').format(log.createdAt),
              ),
              const SizedBox(height: 16),
              if (log.oldData != null) ...[
                const Text(
                  'Dados Anteriores:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _formatJson(log.oldData!),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (log.newData != null) ...[
                const Text(
                  'Dados Novos:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _formatJson(log.newData!),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    final buffer = StringBuffer();
    json.forEach((key, value) {
      if (key != 'is_synced' && key != 'is_deleted') {
        buffer.writeln('$key: $value');
      }
    });
    return buffer.toString().trim();
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _loadLogs();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedTable = null;
      _startDate = null;
      _endDate = null;
    });
    _loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.people), text: 'Usuários'),
            Tab(icon: Icon(Icons.history), text: 'Logs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildUsersTab(), _buildLogsTab()],
      ),
    );
  }

  Widget _buildUsersTab() {
    if (_loadingUsers) {
      return const Center(child: CircularProgressIndicator());
    }

    // Filtrar usuários pela pesquisa
    final filteredUsers = _userSearchQuery.isEmpty
        ? _users
        : _users
              .where(
                (u) => u.email.toLowerCase().contains(
                  _userSearchQuery.toLowerCase(),
                ),
              )
              .toList();

    return Column(
      children: [
        // Campo de pesquisa
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _userSearchController,
            decoration: InputDecoration(
              hintText: 'Buscar por email...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _userSearchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _userSearchController.clear();
                        setState(() => _userSearchQuery = '');
                      },
                    )
                  : null,
              isDense: true,
            ),
            onChanged: (value) => setState(() => _userSearchQuery = value),
          ),
        ),
        // Lista de usuários
        Expanded(
          child: filteredUsers.isEmpty
              ? const Center(child: Text('Nenhum usuário encontrado'))
              : RefreshIndicator(
                  onRefresh: _loadUsers,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: user.isActive
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Colors.grey.shade300,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? Icon(
                                    user.isActive
                                        ? Icons.person
                                        : Icons.person_off,
                                    color: user.isActive
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey,
                                  )
                                : null,
                          ),
                          title: Text(
                            user.email,
                            style: TextStyle(
                              decoration: user.isActive
                                  ? null
                                  : TextDecoration.lineThrough,
                              color: user.isActive ? null : Colors.grey,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              _buildRoleChip(user.role),
                              const SizedBox(width: 8),
                              if (!user.isActive)
                                const Chip(
                                  label: Text('Inativo'),
                                  backgroundColor: Colors.grey,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'toggle_active') {
                                _toggleUserActive(user);
                              } else {
                                _updateUserRole(user, value);
                              }
                            },
                            itemBuilder: (ctx) => [
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
                                child: Text('Definir como Admin'),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                value: 'toggle_active',
                                child: Text(
                                  user.isActive ? 'Desativar' : 'Ativar',
                                ),
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
    );
  }

  Widget _buildRoleChip(String role) {
    final colorScheme = Theme.of(context).colorScheme;
    Color color;
    String label;

    switch (role) {
      case 'admin':
        color = colorScheme.error;
        label = 'Admin';
        break;
      case 'moderator':
        color = colorScheme.tertiary;
        label = 'Moderador';
        break;
      default:
        color = colorScheme.primary;
        label = 'Usuário';
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: color, fontSize: 10),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildLogsTab() {
    return Column(
      children: [
        // Filtros
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Filtro de tabelas
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedTable,
                  decoration: const InputDecoration(
                    labelText: 'Tabela',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Todas')),
                    DropdownMenuItem(
                      value: 'categories',
                      child: Text('Categorias'),
                    ),
                    DropdownMenuItem(value: 'lyrics', child: Text('Letras')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedTable = value);
                    _loadLogs();
                  },
                ),
              ),
              const SizedBox(width: 8),
              // Botão de data
              IconButton(
                icon: Icon(
                  Icons.date_range,
                  color: _startDate != null
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: _selectDateRange,
                tooltip: 'Filtrar por data',
              ),
              // Limpar filtros
              if (_selectedTable != null || _startDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearFilters,
                  tooltip: 'Limpar filtros',
                ),
            ],
          ),
        ),
        // Info do filtro de data
        if (_startDate != null && _endDate != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Período: ${DateFormat('dd/MM/yyyy').format(_startDate!)} - ${DateFormat('dd/MM/yyyy').format(_endDate!)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        const Divider(),
        // Lista de logs
        Expanded(
          child: _loadingLogs
              ? const Center(child: CircularProgressIndicator())
              : _logs.isEmpty
              ? const Center(child: Text('Nenhum log encontrado'))
              : RefreshIndicator(
                  onRefresh: _loadLogs,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: _buildActionIcon(log.action),
                          title: Text(
                            '${log.actionLabel} de ${log.tableLabel}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(log.recordName),
                              Text(
                                '${log.userEmail ?? 'Anônimo'} • ${DateFormat('dd/MM HH:mm').format(log.createdAt)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () => _showLogDetails(log),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(String action) {
    final colorScheme = Theme.of(context).colorScheme;
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
        icon = Icons.delete;
        color = colorScheme.error;
        break;
      default:
        icon = Icons.info;
        color = colorScheme.outline;
    }

    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.2),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
