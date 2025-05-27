import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/upcoming_task_model.dart';
import 'package:get/get.dart';

class UpcomingTaskController extends GetxController {
  var upcomingTasks = <UpcomingTaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingTasks(); // Automatically fetch when controller is created
  }

  void fetchUpcomingTasks() {
    // You can later replace this with a service/API call
    upcomingTasks.value = [
      UpcomingTaskModel(
        title: 'Inspecteer het dak',
        location: 'New York',
        description:
            'Inspecteer het dak voor tekenen van schade. \nZorg ervoor dat alle shingles stevig en in \ngoede staat zijn.',

        date: "30/04/2025",
        time: "11:00 Am",
        status: 'Taak Starten',
      ),
      UpcomingTaskModel(
        title: 'Reinig de goten',
        location: 'Los Angeles',
        description:
            'Verwijder bladeren en vuil uit de goten voor goede afwatering en controleer op blokkades.',
        date: "30/04/2025",
        time: "9:30 Am",
        status: 'Taak Starten',
      ),
      UpcomingTaskModel(
        title: 'Inspecteer de funderin',
        location: 'Chicago ',
        description:
            'Controleer de fundering op scheuren of tekenen van verzakking. Kijk of er water rond de basis van de structuur verzamelt.',
        date: "30/04/2025",
        time: "2:00 pm",
        status: 'Taak Starten',
      ),
      UpcomingTaskModel(
        title: 'Controleer de ramen',
        location: 'Miami',
        description:
            'Inspecteer de ramen op eventuele luchtlekkages en zorg ervoor dat ze goed sluiten. Vervang beschadigde of oude ramen waar nodig.',
        date: "16/04/2025",
        time: "11:00 Am",
        status: 'Taak Starten',
      ),
      UpcomingTaskModel(
        title: "Test de HVAC-systemen",
        location: 'Dallas',
        description:
            'Controleer de verwarming, ventilatie en airconditioning systemmen op goede werking en vervang indien nodig filters.',
        date: "15/04/2025",
        time: "11:00 Am",
        status: 'Taak Starten',
      ),
      UpcomingTaskModel(
        title: 'Evalueer de buitenverlichting',
        location: 'Seattle',

        description:
            "Controleer de buitenverlichting en vervang \ndefecte lampen voor veiligheid.",
        date: "16/04/2025",
        time: "5:30 pm",
        status: 'Taak Starten',
      ),
    ];
  }
}
