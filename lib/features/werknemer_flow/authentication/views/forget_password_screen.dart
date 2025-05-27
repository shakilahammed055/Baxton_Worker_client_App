import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/authentication/controllers/forget_password_controller.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/forget_password_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Wachtwoord vergeten",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  "Voer uw e-mailadres of telefoonnummer in voor de code.",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF5F5F5F),
                    lineHeight: 12,
                  ),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (controller.toggleValue.value != 0) {
                        controller.toggle();
                      }
                    },
                    child: Container(
                      width: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryGold,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Text(
                            "Email",
                            style: getTextStyle(
                              color:
                                  controller.toggleValue.value == 0
                                      ? Colors.white
                                      : const Color(0xFF3A4C67),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Obx(
                    () => Text(
                      controller.toggleValue.value == 0 ? "E-mail" : "Phone",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Obx(
                  () => AuthCustomTextField(
                    controller:
                        controller.toggleValue.value == 0
                            ? controller.emailController
                            : controller.phoneController,
                    text:
                        controller.toggleValue.value == 0
                            ? "Enter your Email"
                            : "Enter your phone number",
                  ),
                ),
                const SizedBox(height: 60),
                CustomContinueButton(
                  onTap: () {
                    // final email = controller.emailController.text.trim();
                    // if (email.isNotEmpty && GetUtils.isEmail(email)) {
                    //   // controller.forgetPassword();
                    // } else {
                    //   EasyLoading.showError("Please enter a valid email");
                    // }
                    Get.to(ForgetPasswordOtpScreen());
                  },
                  title: "Verzenden",
                  textColor: Colors.white,
                  backgroundColor: Color(0xff1E90FF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
