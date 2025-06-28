import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/enums/snackbar_type.dart';

void setupSnackbarUI() {
  final snackbarService = locator<SnackbarService>();

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 0.0, 16.0),
      margin: const EdgeInsets.all(12),
      backgroundColor: const Color(0xFF303030),
      borderRadius: 6.0,
      icon: const Icon(Icons.close_rounded, color: Colors.white),
      duration: const Duration(seconds: 2),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.failedConnection,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 0.0, 16.0),
      margin: const EdgeInsets.all(12),
      backgroundColor: const Color(0xFF303030),
      borderRadius: 6.0,
      animationDuration: const Duration(seconds: 3),
      icon: const Icon(Icons.close_rounded, color: Colors.white),
      isDismissible: false,
    ),
  );
}
