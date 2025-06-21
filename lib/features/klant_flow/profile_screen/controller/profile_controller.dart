import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart'; // Make sure to import your AuthService

class ProfileController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController experiecnceController = TextEditingController();
  final TextEditingController preferredController = TextEditingController();
  final TextEditingController interviewController = TextEditingController();
  final TextEditingController confidenceController = TextEditingController();
  final TextEditingController currentplanController = TextEditingController();

  var isEditing = false.obs;
  var isSaving = false.obs;
  final logoUrl = ''.obs;
  var selectedImagePath = ''.obs;
  var isEnable = false.obs;

  final ImagePicker _imagePicker = ImagePicker();

  // Method to log the user out
  Future<void> logout() async {
    EasyLoading.show(status: 'Logging out...');
    try {
      await AuthService.clearAuthData();

      Get.offAll(() => LoginScreen());
    } catch (e) {
      EasyLoading.showError("An error occurred while logging out");
      debugPrint("Logout Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void saveProfile() {
    // Logic for saving the profile (e.g., updating a database or API call)
    isSaving.value = false; // Reset the save button
    isEditing.value = false; // Turn off editing mode
  }

  void toggleEdit() {
    isEnable.value = !isEnable.value;
    isSaving.value = false;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      } else {
        Get.snackbar("No Image Selected", "Please select an image.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick an image: $e");
    }
  }

  File getSelectedImage() {
    return File(selectedImagePath.value);
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_outlined),
              title: Text('Choose from Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
