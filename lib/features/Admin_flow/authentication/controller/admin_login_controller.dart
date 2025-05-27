import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController{

  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

}