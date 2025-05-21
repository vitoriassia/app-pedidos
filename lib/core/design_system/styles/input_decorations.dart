import 'package:flutter/material.dart';

class InputDecorations {
  /// Returns a standard outline decoration with rounded corners.
  ///
  /// [label] is the field label text.
  /// [context] is required for theme-based colors.
  static InputDecoration outline({required String label, required BuildContext context}) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade700),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: theme.primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
