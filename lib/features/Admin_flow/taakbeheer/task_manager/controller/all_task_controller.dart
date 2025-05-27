import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_model.dart';
import 'package:get/get.dart';

class AllTasksController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.assignAll([
      Task(
        title: 'Dakinspectie op 258 Cedar St',
        location: 'New York',
        assignee: 'Albert Flores',
        date: DateTime(2025, 4, 17),
        status: TaskStatus.bezig,
      ),
      Task(
        title: 'Dakinspectie op 258 Cedar St',
        location: 'New York',
        assignee: 'Albert Flores',
        date: DateTime(2025, 4, 17),
        status: TaskStatus.voltooid,
      ),
      Task(
        title: 'Dakinspectie op 258 Cedar St',
        location: 'New York',
        assignee: 'Albert Flores',
        date: DateTime(2025, 4, 17),
        status: TaskStatus.teLaat,
      ),
      Task(
        title: 'Dakinspectie op 258 Cedar St',
        location: 'New York',
        assignee: 'Albert Flores',
        date: DateTime(2025, 4, 17),
        status: TaskStatus.nietToegewezen,
      ),
      Task(
        title: 'Dakinspectie op 258 Cedar St',
        location: 'New York',
        assignee: 'Albert Flores',
        date: DateTime(2025, 4, 17),
        status: TaskStatus.bezig,
      ),
    ]);
  }
}
