// packages/core_ui/lib/src/widgets/app_snackbar.dart
import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = switch (type) {
      SnackbarType.success => Colors.green.shade700,
      SnackbarType.error => colorScheme.error,
      SnackbarType.warning => Colors.orange.shade700,
      SnackbarType.info => colorScheme.primary,
    };

    final icon = switch (type) {
      SnackbarType.success => Icons.check_circle_outline,
      SnackbarType.error => Icons.error_outline,
      SnackbarType.warning => Icons.warning_amber_rounded,
      SnackbarType.info => Icons.info_outline,
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          backgroundColor: backgroundColor,
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }
}
