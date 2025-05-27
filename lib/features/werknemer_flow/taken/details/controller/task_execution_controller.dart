// import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class TaskExecutionController extends GetxController {
//   final selectedImagePath = ''.obs;
//   final capturedImagePath = ''.obs;

//   var workItems =
//       <Map<String, String>>[].obs; // Holds list of work name and price
//   var checkList = <TaskCheckItem>[].obs;

//   double get progress =>
//       checkList.isEmpty
//           ? 0
//           : checkList.where((e) => e.isChecked).length / checkList.length;

//   void addWorkItem(String name, String price) {
//     workItems.add({'name': name, 'price': price});
//   }

//   void addCheckItem(String title) {
//     checkList.add(TaskCheckItem(title: title));
//   }

//   void toggleCheck(int index, bool? value) {
//     checkList[index].isChecked = value ?? false;
//     checkList.refresh();
//   }

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       selectedImagePath.value = pickedFile.path;
//     }
//   }

//   Future<void> captureImage() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       selectedImagePath.value = capturedFile.path;
//     }
//   }
// }

import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TaskExecutionController extends GetxController {
  final capturedImagePathAfter = ''.obs; // for "Maak foto na afloop"
  final capturedImagePathBefore = ''.obs; // for "Na foto"

  var workItems = <Map<String, String>>[].obs; // Work name and price
  var checkList = <TaskCheckItem>[].obs;

  double get progress =>
      checkList.isEmpty
          ? 0
          : checkList.where((e) => e.isChecked).length / checkList.length;

  void addWorkItem(String name, String price) {
    workItems.add({'name': name, 'price': price});
  }

  void addCheckItem(String title) {
    checkList.add(TaskCheckItem(title: title));
  }

  void toggleCheck(int index, bool? value) {
    checkList[index].isChecked = value ?? false;
    checkList.refresh();
  }

  Future<void> captureImageAfter() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      capturedImagePathAfter.value = capturedFile.path;
    }
  }

  Future<void> captureImageBefore() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      capturedImagePathBefore.value = capturedFile.path;
    }
  }
}
