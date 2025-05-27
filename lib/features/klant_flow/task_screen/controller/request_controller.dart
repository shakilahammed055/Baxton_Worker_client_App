import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RequestController extends GetxController {
  // Text controllers
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController postcodecontroller = TextEditingController();
  TextEditingController describecontroller = TextEditingController();
  TextEditingController problemcontroller = TextEditingController();

  // Observable variables
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;
  var selectedImage = Rx<File?>(null);

  // Simplified image picker method
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  @override
  void onClose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    citycontroller.dispose();
    postcodecontroller.dispose();
    describecontroller.dispose();
    problemcontroller.dispose();
    super.onClose();
  }
}
