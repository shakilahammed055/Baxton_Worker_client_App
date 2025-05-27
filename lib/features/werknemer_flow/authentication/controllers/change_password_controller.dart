
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final newPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    newPasswordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.onClose();
  }

  void clearErrors() {
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  bool validatePasswords() {
    clearErrors();
    bool isValid = true;

    if (newPasswordEditingController.text.isEmpty) {
      newPasswordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (newPasswordEditingController.text.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      isValid = false;
    }

    if (confirmPasswordEditingController.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      isValid = false;
    } else if (newPasswordEditingController.text !=
        confirmPasswordEditingController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  // Future<void> changePassword([String? email]) async {
  //   if (!validatePasswords()) {
  //     debugPrint('Password validation failed.');
  //     return;
  //   }

  //   try {
  //     EasyLoading.show(status: 'Changing Password...');
  //     debugPrint('Fetching SharedPreferences...');
  //     final prefs = await SharedPreferences.getInstance();
  //     final accessToken = prefs.getString('token');

  //     if (accessToken == null || accessToken.isEmpty) {
  //       debugPrint('Access token not found or empty.');
  //       EasyLoading.showError('Session expired. Please try again.');
  //       return;
  //     }

  //     final newPassword = confirmPasswordEditingController.text;
  //     debugPrint('Access token found: $accessToken');
  //     debugPrint('New password: $newPassword');

  //     final Map<String, dynamic> requestBody = {
  //       "token": accessToken,
  //       "newPassword": newPassword,
  //     };

  //     if (email != null && email.isNotEmpty) {
  //       requestBody["email"] = email;
  //       debugPrint('Email provided: $email');
  //     } else {
  //       debugPrint('No email provided.');
  //     }

  //     final requestJson = jsonEncode(requestBody);
  //     debugPrint('Request body JSON: $requestJson');

  //     final response = await http.post(
  //       Uri.parse(Urls.changepassword),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': accessToken,
  //       },
  //       body: requestJson,
  //     );

  //     debugPrint('Status Code: ${response.statusCode}');
  //     debugPrint('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       debugPrint('Password change successful.');
  //       EasyLoading.showSuccess('Password changed successfully!');
  //       await prefs.remove('token');
  //       debugPrint('Token removed from SharedPreferences.');
  //       Get.offAllNamed(AppRoute.loginScreen);
  //     } else {
  //       debugPrint('Password change failed with status ${response.statusCode}');
  //       final errorData = jsonDecode(response.body);
  //       final errorMessage =
  //           errorData['message'] ?? 'Failed to change password';
  //       debugPrint('Error Message: $errorMessage');
  //       EasyLoading.showError(errorMessage);
  //     }
  //   } catch (e) {
  //     debugPrint('Exception occurred: $e');
  //     EasyLoading.showError('Error changing password: $e');
  //   } finally {
  //     debugPrint('Dismissing EasyLoading...');
  //     EasyLoading.dismiss();
  //   }
  // }
}
