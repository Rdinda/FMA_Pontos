import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../theme/app_colors.dart';

/// Salmon/coral for permission and validation errors (Stitch).
const Color _errorToastBackground = Color(0xFFE07A6B);
const Color _successToastBackground = AppColors.primaryContainer;
const Color _toastOnBackground = Colors.white;

class SnackbarUtils {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    SnackBarAction? action,
  }) {
    final toastBackground =
        isError ? _errorToastBackground : _successToastBackground;

    toastification.dismissAll();

    late final ToastificationItem item;
    item = toastification.show(
      context: context,
      type: isError ? ToastificationType.error : ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 4),
      dragToClose: true,
      closeOnClick: false,
      showIcon: true,
      applyBlurEffect: false,
      // fillColored: primaryColor = fill; backgroundColor param = text/icon (surfaceLight).
      primaryColor: toastBackground,
      backgroundColor: _toastOnBackground,
      foregroundColor: _toastOnBackground,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.none,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: _toastOnBackground,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.3,
              ),
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: () {
                toastification.dismiss(item);
                action.onPressed();
              },
              style: TextButton.styleFrom(
                foregroundColor: _toastOnBackground,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                action.label,
                style: const TextStyle(
                  color: _toastOnBackground,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
