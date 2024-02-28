import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SnackbarMixin on GetxController {
  showdeletSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade200,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
    ).show(Get.context!);
  }

  showcreateSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green.shade300,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
    ).show(Get.context!);
  }
}
