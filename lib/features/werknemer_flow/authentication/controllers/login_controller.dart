import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WLoginScreenController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Controller for the text field
  TextEditingController categoryController = TextEditingController();

  // Dummy userId for new category (replace with actual userId)
  String userId = "user123";

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }

  // Fetch categories from the API
}
