import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_creation_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/views/employee_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TaskCreationController extends GetxController {
  final selectedEmployee = Rxn<Employee>();
  final taskTypes =
      [
        "Inspect the roof",
        "Repair electrical issue",
        "Fix plumbing problem",
        "Interior design consultation",
      ].obs;

  var selectedTaskType = "Inspect the roof".obs;
  var selectedAssignee = ''.obs;
  var expertise = ''.obs;

  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController(text: '11:00 uur');

  var preferredDate = DateTime.now().obs;

  void createTask() {
    final task = TaskCreationModel(
      taskType: selectedTaskType.value,
      description: descriptionController.text,
      clientName: nameController.text,
      clientPhone: phoneController.text,
      clientLocation: locationController.text,
      preferredDate: preferredDate.value,
      preferredTime: timeController.text,
      assignedTo: selectedAssignee.value,
      expertise: expertise.value,
    );

    // ignore: avoid_print
    print("Task Created: ${task.taskType}, for ${task.clientName}");
    Get.snackbar("Success", "Taak aangemaakt!");
  }

  void openEmployeeSelection() {
    Get.to(() => EmployeeScreen());
  }

  void cancel() {
    Get.back();
  }
}
