import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:get/get.dart';

class TaskOverviewController extends GetxController {
  var stats =
      TaskStats(
        assigned: 45,
        inProgress: 25,
        completed: 15,
        overdue: 10,
        unassigned: 5,
      ).obs;
  void updateStats(TaskStats newStats) {
    stats.value = newStats;
  }

  
}
