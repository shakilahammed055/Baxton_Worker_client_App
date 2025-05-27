import 'package:get/get.dart';

import '../models/home_model.dart';

class HomeController extends GetxController {
  // This will be your data model
  final List<Service> _services = [
    Service(
      title: "Schimmelbehandeling",
      location: "New York",
      description: "Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.",
      time: "11:00 Am",
    ),
    Service(
      title: "Schimmelbehandeling",
      location: "New York",
      description: "Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.",
      time: "11:00 Am",
    ),
    Service(
      title: "Roof Inspection",
      location: "Los Angeles",
      description: "Inspect and repair the roof to ensure its durability and safety.",
      time: "02:00 PM",
    ),
    // Add more services here as required
  ];

  // Function to get only the first two services
  List<Service> getFirstTwoServices() {
    return _services.take(2).toList();
  }
}
