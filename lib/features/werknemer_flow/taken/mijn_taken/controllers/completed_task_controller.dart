import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/completed_task_model.dart';
import 'package:get/get.dart';

class CompletedTaskController extends GetxController {
  var completedTasks =
      <CompletedTaskModel>[
        CompletedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
        ),
        // Duplicate for demo
        CompletedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
        ),
        CompletedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
        ),
        CompletedTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          description:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
        ),
      ].obs;
}
