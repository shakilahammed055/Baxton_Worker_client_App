// import 'package:get/get.dart';

// class ProfileController extends GetxController {
//   var name = ''.obs;
//   var phoneNumber = ''.obs;
//   var email = ''.obs;
//   var location = ''.obs;

//   void updateName(String value) {
//     name.value = value;
//   }

//   void updatePhoneNumber(String value) {
//     phoneNumber.value = value;
//   }

//   void updateEmail(String value) {
//     email.value = value;
//   }

//   void updateLocation(String value) {
//     location.value = value;
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingController extends GetxController {
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

  void saveProfile() {
    // Logic for saving the profile (e.g., updating a database or API call)
    isSaving.value = false; // Reset the save button
    isEditing.value = false; // Turn off editing mode
  }

  void toggleEdit() {
    isEnable.value = !isEnable.value;
    isSaving.value = false;
  }

  final ImagePicker _imagePicker = ImagePicker();

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
