import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/confirmed_task_model.dart';
import 'package:get/get.dart';

// class EmployeeHomeController extends GetxController {
//   var userName = 'Russell'.obs;
//   var completedTasks = 60.obs;
//   var confirmedTasks =
//       <ConfirmedTaskModel>[
//         ConfirmedTaskModel(
//           title: 'Inspecteer het dak',
//           location: 'New York',
//           description:
//               'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

//           price: '\$5000',
//           dateTime: DateTime(2025, 4, 23, 11, 0),
//           isPaymentCompleted: false,
//         ),
//         // Duplicate for demo
//         ConfirmedTaskModel(
//           title: 'Inspecteer het dak',
//           location: 'New York',
//           description:
//               'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

//           price: '\$5000',
//           dateTime: DateTime(2025, 4, 23, 11, 0),
//           isPaymentCompleted: true,
//         ),
//         ConfirmedTaskModel(
//           title: 'Inspecteer het dak',
//           location: 'New York',
//           description:
//               'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

//           price: '\$5000',
//           dateTime: DateTime(2025, 4, 23, 11, 0),
//         ),
//         ConfirmedTaskModel(
//           title: 'Inspecteer het dak',
//           location: 'New York',
//           description:
//               'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

//           price: '\$5000',
//           dateTime: DateTime(2025, 4, 23, 11, 0),
//         ),
//       ].obs;

// }

class EmployeeHomeController extends GetxController {
  var userName = 'Russell'.obs;
  var completedTasks = 60.obs;

  var allTasks =
      <ConfirmedTaskModel>[
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        // Duplicate for demo
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        ConfirmedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
      ].obs;

  List<ConfirmedTaskModel> get confirmedTasks =>
      allTasks.where((task) => task.isPaymentCompleted).toList();

  List<ConfirmedTaskModel> get paymentPendingTasks =>
      allTasks.where((task) => !task.isPaymentCompleted).toList();

  void completePayment(ConfirmedTaskModel task) {
    final index = allTasks.indexOf(task);
    if (index != -1) {
      allTasks[index].isPaymentCompleted = true;
      allTasks.refresh(); // Trigger UI update
    }
  }
}
