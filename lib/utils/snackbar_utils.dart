import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../theme/app_colors.dart';

/// Salmon/red background for permission and validation errors.
const Color _errorToastBackground = Color(0xFFE07A6B);
const Color _errorToastForeground = Colors.white;

class SnackbarUtils {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    SnackBarAction? action,
  }) {
    final theme = Theme.of(context);

    final backgroundColor =
        isError ? _errorToastBackground : AppColors.primaryContainer;
    final foregroundColor =
        isError ? _errorToastForeground : Colors.white;

    toastification.dismissAll();

    late final ToastificationItem item;
    item = toastification.show(
      context: context,
      type: isError ? ToastificationType.error : ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      dragToClose: true,
      closeOnClick: false,
      showIcon: true,
      applyBlurEffect: false,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      primaryColor: backgroundColor,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.none,
      ),
      title: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: foregroundColor,
            size: 22,
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
          if (action != null)
            TextButton(
              onPressed: () {
                toastification.dismiss(item);
                action.onPressed();
              },
              child: Text(
                action.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
