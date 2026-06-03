import 'package:flutter/material.dart';

/// Paleta streaming extraída dos mocks Stitch (`Home_Acervo.html`).
abstract final class AppColors {
  // Brand / primary
  static const Color primaryContainer = Color(0xFF1DB954);
  static const Color primaryHighlight = Color(0xFF53E076);
  static const Color onPrimary = Color(0xFF003914);
  static const Color onPrimaryContainer = Color(0xFF004118);

  // Dark surfaces
  static const Color surfaceDark = Color(0xFF131313);
  static const Color surfaceContainerLowDark = Color(0xFF1C1B1B);
  static const Color surfaceContainerDark = Color(0xFF201F1F);
  static const Color surfaceContainerHighDark = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighestDark = Color(0xFF353534);
  /// Fundo do painel de letras (player expandido).
  static const Color lyricsPanelBackground = Color(0xFF222222);
  static const Color onSurfaceDark = Color(0xFFE5E2E1);
  static const Color onSurfaceVariantDark = Color(0xFFBCCBB9);
  static const Color outlineDark = Color(0xFF869585);
  static const Color outlineVariantDark = Color(0xFF3D4A3D);

  // Light surfaces (espelhado — D-10)
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceContainerLowLight = Color(0xFFEEEEEE);
  static const Color surfaceContainerLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerHighLight = Color(0xFFF0F0F0);
  static const Color surfaceContainerHighestLight = Color(0xFFE8E8E8);
  static const Color onSurfaceLight = Color(0xFF1C1B1B);
  static const Color onSurfaceVariantLight = Color(0xFF49454F);
  static const Color outlineLight = Color(0xFF79747E);
  static const Color outlineVariantLight = Color(0xFFCAC4D0);

  // Role badges (RN-04)
  static const Color roleAdmin = Color(0xFF1DB954);
  static const Color roleModerator = Color(0xFFBB86FC);
  static const Color roleUser = Color(0xFF9E9E9E);
  static const Color roleInactive = Color(0xFF616161);

  // Rank decorations (TopPlayed)
  static const Color rankGold = Color(0xFFFFB300);
  static const Color rankSilver = Color(0xFF9E9E9E);
  static const Color rankBronze = Color(0xFF8D6E63);

  static Color roleColor(String role) {
    switch (role) {
      case 'admin':
        return roleAdmin;
      case 'moderator':
        return roleModerator;
      default:
        return roleUser;
    }
  }
}
