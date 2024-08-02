import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin BaseController {
  void showLoading() {
    Get.dialog(
      const Dialog(
        child: SizedBox(
          height: 150,
          width: 150,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
