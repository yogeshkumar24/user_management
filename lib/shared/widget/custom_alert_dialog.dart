import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog {
  static void show({
    required String title,
    required String message,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
