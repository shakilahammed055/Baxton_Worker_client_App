import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:get/get.dart';

class TaskRequestController extends GetxController {
  var taskRequests =
      <TaskRequest>[
        TaskRequest(
          title: "Landschapsarchitectuur op 258 Cedar St",
          user: "David Wilson",
          timeAgo: "5 minuten geleden",
        ),
        TaskRequest(
          title: "Algemeen onderhoud op 147 Maple St",
          user: "Sarah Davis",
          timeAgo: "10 minuten geleden",
        ),
        TaskRequest(
          title: "Elektrisch werk op 321 Pine St",
          user: "Sarah Davis",
          timeAgo: "15 minuten geleden",
        ),
      ].obs;
}
