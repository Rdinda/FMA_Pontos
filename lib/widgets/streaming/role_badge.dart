import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Badge de papel RBAC no painel admin (RN-04).
class RoleBadge extends StatelessWidget {
  final String role;
  final String label;
  final bool isActive;

  const RoleBadge({
    super.key,
    required this.role,
    required this.label,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.roleColor(role) : AppColors.roleInactive;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
