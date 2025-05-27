import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );

    Get.put(EmployeeController());
    Get.put(EmployeeHomeController());
    Get.put(ClientInfoController());
  }
}
