import 'package:flutter/material.dart';

class MyAppMethods {
  static Future<void> showWarningDialouge({
    required BuildContext context,
    required String label,
    required VoidCallback onPressedOk,
    required VoidCallback onPressedCancel,
    bool isError = true,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(label),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: onPressedCancel,
                        child: const Text('Cancel'),
                      ),
                    ),
                    TextButton(
                      onPressed: onPressedCancel,
                      child: const Text('Ok'),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
