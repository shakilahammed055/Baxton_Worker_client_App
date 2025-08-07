import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  var employeeList = <Employee>[].obs;
  var selectedEmployeeIndex = (-1).obs;

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  void fetchEmployees() {
  }

  void selectEmployee(int index) {
    selectedEmployeeIndex.value = index;
  }
}
