import 'package:flutter/material.dart';
import 'package:pedidos_app/main.dart';

/// Helper to show application-wide SnackBars.
abstract class SnackbarHelper {
  /// Displays a success SnackBar with a green background.
  static void showSuccess(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  /// Displays an error SnackBar with a red background.
  static void showError(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
