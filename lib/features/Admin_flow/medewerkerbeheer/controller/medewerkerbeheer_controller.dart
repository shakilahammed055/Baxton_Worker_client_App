import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedewerkerbeheerController extends GetxController {
  var searchController = TextEditingController();

  String? selectedLocation;
  String? selectedExpertise;
  var selectedPosition = 'Choose option'.obs;
  void setPosition(String position) {
    selectedPosition.value = position;
  }

  // Setters
  void setSelectedLocation(String location) {
    selectedLocation = location;
    update();
  }

  void setSelectedExpertise(String expertise) {
    selectedExpertise = expertise;
    update();
  }

  //==================================================
  final List<Task> tasks = [
    Task(
      title: "Landschapsarchitectuur op 258 Cederstraat",
      userName: "David Wilson",
      date: "18 April,2025",
      status: "In Afwachting",
      statusColor: const Color(0xffE9F4FF),
      statusTextColor: const Color(0xff1E90FF),
    ),
    Task(
      title: "Dakreparatie op 12 Esdoornlaan",
      userName: "Jessica Adams",
      date: "18 April,2025",
      status: "In Afwachting",
      statusColor: const Color(0xffE9F4FF),
      statusTextColor: const Color(0xff1E90FF),
    ),
    Task(
      title: "Keukenverbouwing op 45 Eikendreef",
      userName: "Michael Lee",
      date: "20 April, 2025",
      status: "Voltooid",
      statusColor: const Color(0xffEBEBEB),
      statusTextColor: AppColors.textPrimary,
    ),

    Task(
      title: "Landschapsarchitectuur op 258 Cederstraat",
      userName: "David Wilson",
      date: "20 April, 2025",
      status: "Voltooid",
      statusColor: const Color(0xffEBEBEB),
      statusTextColor: AppColors.textPrimary,
    ),
    // Add more tasks as needed
  ];

  //======================================================

  final List<Map<String, String>> profiles = [
    {
      'imagePath': IconPath.profilepic,
      'name': 'Theresa Webb',
      'designation': 'Dak Specialist',
    },
    {
      'imagePath': IconPath.profilepic,
      'name': 'John Doe',
      'designation': 'Senior Developer',
    },
    {
      'imagePath': IconPath.profilepic,
      'name': 'Theresa Webb',
      'designation': 'Dak Specialist',
    },
    {
      'imagePath': IconPath.profilepic,
      'name': 'John Doe',
      'designation': 'Senior Developer',
    },
    {
      'imagePath': IconPath.profilepic,
      'name': 'Theresa Webb',
      'designation': 'Dak Specialist',
    },
    {
      'imagePath': IconPath.profilepic,
      'name': 'John Doe',
      'designation': 'Senior Developer',
    },
  ];
}
