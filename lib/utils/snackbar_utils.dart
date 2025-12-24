import 'package:flutter/material.dart';

class SnackbarUtils {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use primary color for success/info to match app theme as requested
    // Use error color for errors
    final backgroundColor = isError ? colorScheme.error : colorScheme.primary;
    final foregroundColor = isError
        ? colorScheme.onError
        : colorScheme.onPrimary;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: foregroundColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 6,
        duration: duration,
        action: action != null
            ? SnackBarAction(
                label: action.label,
                textColor: foregroundColor,
                onPressed: action.onPressed,
              )
            : null,
      ),
    );
  }
}
