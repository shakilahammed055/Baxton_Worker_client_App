import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/authentication.dart/controller/signup_controller.dart';
import 'package:baxton/features/klant_flow/authentication.dart/screens/login_screen.dart';
import 'package:baxton/features/klant_flow/bottom_navigationbar/screens/bottom_navigation_ber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  SignupController singupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Aanmelden',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Naam',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                text: 'Voer uw naam in',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                controller: singupController.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Telefoonnummer',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: singupController.phoneController1,
                text: 'Voer uw telefoonnummer in',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voer uw telefoonnummer in e.g:+8801234567891';
                  }
                  RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Ongeldig telefoonnummerformaat. Gebruik +8801XXXXXXXXX';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: getTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: singupController.emailController1,
                text: 'Voer uw e-mail in',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email address';
                  }

                  RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format. Example: example@mail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Wachtwoord',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () => AuthCustomTextField(
                  text: 'Voer uw wachtwoord in',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  controller: singupController.passwordController,
                  obscureText: singupController.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xff37B874),
                    ),
                    onPressed: singupController.togglePasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wachtwoord is vereist';
                    }
                    if (value.length < 8) {
                      return 'Wachtwoord moet minimaal 8 tekens lang zijn';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Herhaal wachtwoord',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () => AuthCustomTextField(
                  controller: singupController.retypepasswordController,
                  text: 'Voer uw wachtwoord in',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  obscureText: singupController.isPasswordVisible1.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible1.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xff37B874),
                    ),
                    onPressed: singupController.togglePasswordVisibility1,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bevestig uw wachtwoord';
                    }
                    if (value != singupController.passwordController.text) {
                      return 'Wachtwoorden komen niet overeen';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  title: 'Aanmelden',
                  textcolor: Colors.white,
                  onPress: singupController.isFromValid.value ? () {
                    Get.offAll(BottomNavbar());
                  } : null,
                  backgroundColor: AppColors.buttonPrimary,
                  borderColor: Color(0xFFEBF8F1),
                ),
              ),
              SizedBox(height: 28),
              SizedBox(height: 32),
              if (Platform.isAndroid || Platform.isIOS) ...[],
              SizedBox(height: 16),
              if (Platform.isIOS) ...[],
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Heb je al een account?",
                    style: getTextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Inloggen",
                      style: getTextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
