import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  // Controllers - GetX will manage disposal automatically
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();

  // Observables
  var resendEnabled = true.obs;
  var isFormValid = false.obs;
  var errorColor = false.obs;
  var toggleValue = 0.obs;
  var countdown = 120.obs;
  Timer? timer;

  void toggle() {
    toggleValue.value = toggleValue.value == 0 ? 1 : 0;
  }

  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
  }

  void startCountdown() {
    resendEnabled.value = false;
    countdown.value = 120;
    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  // Future<void> forgetPassword() async {
  //   try {
  //     EasyLoading.show(status: 'Sending OTP...');
  //     final email = emailController.text.trim();

  //     if (email.isEmpty || !GetUtils.isEmail(email)) {
  //       EasyLoading.showError("Please enter a valid email");
  //       return;
  //     }

  //     final response = await http.post(
  //       Uri.parse(Urls.forgetPassword),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email}),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseData = jsonDecode(response.body);
  //       final resetLink = responseData['body']['token'];

  //       if (resetLink != null && resetLink.isNotEmpty) {
  //         final prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('token', resetLink);

  //         EasyLoading.showSuccess('OTP Sent Successfully');
  //         startCountdown();

  //         Get.to(
  //           () => ForgetPasswordOtpScreen(),
  //           arguments: {'email': email, 'token': resetLink},
  //         );
  //       }
  //     } else {
  //       final errorData = jsonDecode(response.body);
  //       EasyLoading.showError(errorData['message'] ?? "Failed to send OTP");
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Something went wrong: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  // Future<void> forgetpasswordValidatepin(String email) async {
  //   try {
  //     EasyLoading.show(status: 'Verifying OTP...');
  //     final prefs = await SharedPreferences.getInstance();
  //     final accessToken = prefs.getString('token');

  //     if (accessToken == null || accessToken.isEmpty) {
  //       EasyLoading.showError("Session expired. Please login again.");
  //       return;
  //     }

  //     final otp = pinController.text.trim();
  //     if (otp.isEmpty || otp.length != 6) {
  //       EasyLoading.showError("Please enter a valid 6-digit OTP.");
  //       return;
  //     }

  //     final response = await http.post(
  //       Uri.parse(Urls.verifyOtp),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': accessToken,
  //       },
  //       body: jsonEncode({
  //         "token": accessToken,
  //         "recivedOTP": otp,
  //         "passwordChange": true,
  //       }),
  //     );

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       EasyLoading.showSuccess('OTP Verified Successfully');
  //       pinController.clear();
  //       Get.to(() => ChangePassword());
  //     } else {
  //       final responseData = jsonDecode(response.body);
  //       final errorMessage = responseData['message'] ?? 'An error occurred';
  //       errorColor.value = true;
  //       EasyLoading.showError(errorMessage);
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Something went wrong: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
    Future<void> forgetpasswordValidatepin(String email) async {
    
    Get.snackbar(
      'Success',
      'OTP Verified for $email',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
