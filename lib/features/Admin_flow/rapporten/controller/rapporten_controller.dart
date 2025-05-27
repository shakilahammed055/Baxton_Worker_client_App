import 'package:get/get.dart';

class RapportenController extends GetxController {
  var tasksCompleted = 120.obs;
  var tasksPending = 25.obs;
  var totalEmployees = 15.obs;
  var revenue = 10000.obs;
  var revenueGrowth = 5.34.obs;

  void updateStats() {
    // Simulate stats update
    tasksCompleted.value = 125;
    tasksPending.value = 20;
    totalEmployees.value = 16;
    revenue.value = 11000;
    revenueGrowth.value = 6.45;
  }

  List<Map<String, dynamic>> reviews = [
    {
      'name': 'Emily Parker',
      'profileImage': 'assets/icons/profilepic.png',
      'rating': 4.5,
      'reviewText':
          'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
    },
    {
      'name': 'John Doe',
      'profileImage': 'assets/icons/profilepic.png',
      'rating': 5.0,
      'reviewText':
          'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
    },
    {
      'name': 'Emily Parker',
      'profileImage': 'assets/icons/profilepic.png',
      'rating': 4.5,
      'reviewText':
          'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
    },
    {
      'name': 'John Doe',
      'profileImage': 'assets/icons/profilepic.png',
      'rating': 5.0,
      'reviewText':
          'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
    },
    // Add more reviews as needed
  ];

  var totalTasks = 40.obs;
  var inBehandeling = 50.0.obs; // 50%
  var nietToegewezen = 25.0.obs; // 25%
  var voltooid = 20.0.obs; // 20%

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    // Initialize data if needed
  }

  var selectedValue = 'Deze Maand'.obs;

  // Update the selected value when user selects a new option
  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
  }
}
