import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/home_screen/models/fetch_profile_model.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/new_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeController extends GetxController {
  final NewTaskController newTaskController = Get.put(NewTaskController());
  // Reactive profile state
  final Rx<Profile?> profile = Rx<Profile?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('HomeController onInit called');
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    debugPrint('Starting fetchUserProfile');
    isLoading.value = true;
    errorMessage.value = '';
    await EasyLoading.show(status: 'Loading profile...');

    try {
      final token = await AuthService.getToken();
      debugPrint('Retrieved token: ${token?.substring(0, 10)}...');

      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        errorMessage.value = 'User is not authenticated. Please log in.';
        await EasyLoading.showError('User is not authenticated. Please log in.');
        Get.offAllNamed('/login');
        return;
      }

      final url = Uri.parse(Urls.userdetails);
      debugPrint('Parsed URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      debugPrint('Received response with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          profile.value = profileFromJson(response.body);
          if (!profile.value!.success) {
            debugPrint('API returned success: false - ${profile.value!.message}');
            errorMessage.value = profile.value!.message;
            await EasyLoading.showError(profile.value!.message);
            return;
          }
          profile.refresh();
          debugPrint('Successfully set profile: ${profile.value!.data.user.name}');
          await EasyLoading.showSuccess('Profile loaded successfully!');
          // Fetch tasks only after successful profile load
          await newTaskController.fetchTasks();
        } catch (e) {
          debugPrint('JSON parsing error: $e');
          errorMessage.value = 'Invalid server response. Please try again.';
          await EasyLoading.showError('Invalid server response.');
        }
      } else {
        debugPrint('Failed to load profile: ${response.statusCode} - ${response.body}');
        errorMessage.value = 'Failed to load profile: ${response.statusCode}';
        await EasyLoading.showError('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      errorMessage.value = 'Error fetching profile: $e';
      await EasyLoading.showError('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
      debugPrint('Completed fetchUserProfile');
    }
  }

 
}