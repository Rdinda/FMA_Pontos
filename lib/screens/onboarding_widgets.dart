import 'package:flutter/material.dart';

import 'privacy_policy_screen.dart';

class OnboardingSlide extends StatelessWidget {
  final PageController controller;
  final int index;
  final String title;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.controller,
    required this.index,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final page = controller.hasClients
            ? (controller.page ?? index.toDouble())
            : index.toDouble();
        final delta = (page - index).abs().clamp(0.0, 1.0);
        final opacity = (1.0 - delta).clamp(0.0, 1.0);
        final translateY = 36.0 * delta;
        final scale = 1.0 - (0.04 * delta);

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const BreathingLogo(),
            const SizedBox(height: 28),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Axé, com organização e respeito.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.85),
                letterSpacing: 0.2,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    'Quem tem pemba joga fora.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class OnboardingPrivacySlide extends StatelessWidget {
  final PageController controller;
  final int index;
  final bool accepted;
  final ValueChanged<bool?> onAcceptedChanged;

  const OnboardingPrivacySlide({
    super.key,
    required this.controller,
    required this.index,
    required this.accepted,
    required this.onAcceptedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final page = controller.hasClients
            ? (controller.page ?? index.toDouble())
            : index.toDouble();
        final delta = (page - index).abs().clamp(0.0, 1.0);
        final opacity = (1.0 - delta).clamp(0.0, 1.0);
        final translateY = 36.0 * delta;
        final scale = 1.0 - (0.04 * delta);

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const BreathingLogo(),
            const SizedBox(height: 24),
            Text(
              'Respeito e privacidade',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tratamos seus dados com responsabilidade e conforme a lei. Você pode ler a política completa e seguir com tranquilidade.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              child: const Text('Ler Política de Privacidade completa'),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: accepted,
              onChanged: onAcceptedChanged,
              checkColor: colorScheme.onPrimary,
              activeColor: colorScheme.primary,
              title: Text(
                'Li e concordo com a Política de Privacidade e com o uso dos meus dados conforme descrito.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.25,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class BreathingLogo extends StatelessWidget {
  const BreathingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Image.asset(
        'assets/images/splash.png',
        width: 140,
        height: 140,
        fit: BoxFit.cover,
      ),
    );
  }
}
