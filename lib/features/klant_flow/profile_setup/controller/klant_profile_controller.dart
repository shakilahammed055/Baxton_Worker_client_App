// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class KlantProfileController extends GetxController {
//   var name = ''.obs;
//   var phoneNumber = ''.obs;
//   var email = 'example123@gmail.com'.obs;
//   var location = ''.obs;
//   var selectedImagePath = ''.obs;
//   var hasImageChanged = false.obs;
//   var isEditing = false.obs;

//   // Method to handle submit action
//   void onSubmit() {
//     // For now, simply print the values
//     debugPrint("Name: ${name.value}");
//     debugPrint("Phone Number: ${phoneNumber.value}");
//     debugPrint("Email: ${email.value}");
//     debugPrint("Location: ${location.value}");
//   }

//   // Method to handle skip action
//   void onSkip() {
//     // Just print skip action for now
//     debugPrint("Skipped");
//   }

//   final ImagePicker _imagePicker = ImagePicker();

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(source: source);
//       if (pickedFile != null) {
//         selectedImagePath.value = pickedFile.path;
//         hasImageChanged.value = true;

//         // Set editing mode to true so Save button shows up
//         isEditing.value = true;
//       }
//     } catch (e) {
//       EasyLoading.showError("Failed to pick an image: $e");
//     }
//   }

//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt_outlined),
//               title: const Text('Choose from Camera'),
//               onTap: () {
//                 pickImage(ImageSource.camera);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_outlined),
//               title: const Text('Choose from Gallery'),
//               onTap: () {
//                 pickImage(ImageSource.gallery);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class KlantProfileController extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  // var email = 'example123@gmail.com'.obs;
  var location = ''.obs;
  var selectedImagePath = ''.obs;
  var hasImageChanged = false.obs;
  var isEditing = false.obs;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        hasImageChanged.value = true;
        isEditing.value = true;
      }
    } catch (e) {
      EasyLoading.showError("Failed to pick an image: $e");
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: const Text('Choose from Gallery'),
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

  Future<void> onSubmit() async {
    // Validate required fields
    if (name.value.isEmpty) {
      EasyLoading.showError('Name is required');
      return;
    }
    if (location.value.isEmpty) {
      EasyLoading.showError('Location is required');
      return;
    }

    try {
      EasyLoading.show(status: 'Creating profile...');

      // Retrieve token from AuthService
      final token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError('Authentication token is missing');
        return;
      }

      // Prepare multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://freepik.softvenceomega.com/ts/profile/create-client-profile',
        ),
      );

      // Add token to headers
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add form fields
      request.fields['userName'] = name.value;
      // request.fields['email'] = email.value;
      request.fields['location'] = location.value;

      // Add filename and file if an image is selected
      if (selectedImagePath.value.isNotEmpty) {
        final file = File(selectedImagePath.value);
        final filename = path.basename(file.path).toLowerCase();

        // Validate file extension
        if (!filename.endsWith('.jpg') &&
            !filename.endsWith('.jpeg') &&
            !filename.endsWith('.png')) {
          EasyLoading.showError('Only JPG or PNG images are supported');
          return;
        }

        // Determine MIME type based on extension
        String mimeType = 'image/jpeg';
        if (filename.endsWith('.png')) {
          mimeType = 'image/png';
        }

        debugPrint('Uploading file: $filename with MIME type: $mimeType');

        request.fields['profilePic'] = filename;
        request.files.add(
          http.MultipartFile(
            'profilePic',
            file.readAsBytes().asStream(),
            await file.length(),
            filename: filename,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      // Send the request
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${responseBody.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(responseBody.body);
        if (responseData['success'] == true) {
          EasyLoading.showSuccess(
            responseData['message'] ?? 'Profile created successfully!',
          );
          Get.offAllNamed('/bottomnavbar'); // Adjust to your home route
        } else {
          EasyLoading.showError(
            responseData['message'] ?? 'Failed to create profile',
          );
        }
      } else {
        final errorData = jsonDecode(responseBody.body);
        final errorMessage = errorData['message'] ?? 'Failed to create profile';
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
      EasyLoading.showError('Error creating profile: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void onSkip() {
    debugPrint("Skipped");
    Get.offAllNamed('/bottomnavbar'); // Adjust to your home route
  }
}
