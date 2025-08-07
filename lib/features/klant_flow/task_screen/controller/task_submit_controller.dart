import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/repository/task_submit_repository.dart';
import 'package:get/get.dart';

class TaskSubmitController extends GetxController {
  final TaskSubmitRepository _repo = TaskSubmitRepository();

  RxBool isSubmitting = false.obs;

  Future<void> submitTask({
    required String taskId,
    required File signature,
    required int rating,
    required String review,
  }) async {
    try {
      isSubmitting.value = true;

      final token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token is missing. Please log in again.");
        isSubmitting.value = false;
        return;
      }
      final result = await _repo.submitTask(
        taskId: taskId,
        signatureFile: signature,
        rating: rating,
        review: review,
        token: token,
      );

      Get.snackbar("Success", result.message);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
