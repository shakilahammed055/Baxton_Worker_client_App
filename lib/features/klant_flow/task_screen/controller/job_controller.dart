import 'package:baxton/features/klant_flow/task_screen/model/job_model.dart';

import 'package:get/get.dart';

class JobController extends GetxController {
  List<Job> jobList = [];

  JobController() {
    // Sample data for demonstration
    jobList = [
      Job(
        title: 'Schimmelbehandeling',
        location: 'New York',
        description:
            'Inspecteer het dak voor tekenen van schade. \nZorg ervoor dat alle shingles stevig en in \ngoede staat zijn.',
        date: '24 April, 2025',
        status: 'Voltooid',
      ),
      Job(
        title: 'Loodgieterswerk',
        location: 'Los Angeles',
        description: 'Verwijder bladeren en vuil uit de goten. \nControleer op verstoppingen en zorg voor \neen goede afvoer.',
        date: '30 April, 2025',
        status: 'Voltooid',
      ),
      Job(
        title: 'Loodgieterswerk',
        location: 'Chicago ',
        description: 'Voer een grondige inspectie uit van het dak. \nZoek naar scheuren, roest of andere \nproblemen.',
        date: '15 Mei, 2025',
        status: 'Voltooid',
      ),
      // Job(
      //   title: 'Loodgieterswerk',
      //   location: 'Houston',
      //   description: 'Controleer de gevelbekleding op gaten of \nscheuren. Herstel of vervang beschadigde \npanelen.',
      //   date: '15 April, 2025',
      //   status: 'Voltooid',
      // ),
      // Add more job data here
    ];
  }

  List<Job> getJobs() {
    return jobList;
  }
}
