import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnakeBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    backgroundColor: Colors.redAccent,
    maxWidth: 1000,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 10,
  );
}
