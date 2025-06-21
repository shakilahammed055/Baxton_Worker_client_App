import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/all_task_model.dart';
import 'package:get/get.dart';

class EmployeeHomeController extends GetxController {
  var userName = 'Russell'.obs;
  var completedTasks = 60.obs;

  var allTasks =
      <AllTaskModel>[
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        // Duplicate for demo
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
      ].obs;

  List<AllTaskModel> get confirmedTasks =>
      allTasks.where((task) => task.isPaymentCompleted).toList();

  List<AllTaskModel> get paymentPendingTasks =>
      allTasks.where((task) => !task.isPaymentCompleted).toList();

  void completePayment(AllTaskModel task) {
    final index = allTasks.indexOf(task);
    if (index != -1) {
      allTasks[index].isPaymentCompleted = true;
      allTasks.refresh(); // Trigger UI update
    }
  }
}
