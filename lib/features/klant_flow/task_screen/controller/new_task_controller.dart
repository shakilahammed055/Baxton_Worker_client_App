import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/model/all_service_request_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/task_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestServiceTask {
  final String id;
  final String title;
  final String description;
  final String location;
  final String status;
  final String time;
  final Color statusColor;

  RequestServiceTask({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.time,
    required this.statusColor,
  });
}

class PayToTask {
  final String id;
  final String title;
  final String description;
  final String location;
  final String status;
  final String date;
  final Color statusColor;

  PayToTask({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.date,
    required this.statusColor,
  });
}

class NewTaskController extends GetxController {
  // Reactive lists for tasks
  final requesttasks = <RequestServiceTask>[].obs;
  final confirmedTasks = <PayToTask>[].obs;
  final completedTasks = <PayToTask>[].obs;
  final taskDetails = Rxn<Allservicerequest>();

  // API endpoints
  final String apiUrl = 'https://freepik.softvenceomega.com/ts/service-request/get-client-service-request-overview';
  final String taskDetailsUrl = 'https://freepik.softvenceomega.com/ts/service-request/get';

  @override
  void onInit() {
    super.onInit();
    debugPrint('NewTaskController onInit called');
    fetchTasks();
  }

  // Function to fetch tasks from the API
  Future<void> fetchTasks() async {
    try {
      await EasyLoading.show(status: 'Loading tasks...');
      debugPrint('Fetching tasks from $apiUrl');

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        await EasyLoading.showError('Authentication token is missing');
        debugPrint('Error: Authentication token is missing');
        return;
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      debugPrint('Received response with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final taskOverview = Taskoverview.fromJson(json.decode(response.body));

        if (taskOverview.success) {
          requesttasks.clear();
          confirmedTasks.clear();
          completedTasks.clear();

          // Map requested tasks
          requesttasks.addAll(taskOverview.data.requested.map((task) => _mapToRequestServiceTask(task, 'PENDING')));
          
          // Map confirmed tasks
          confirmedTasks.addAll(taskOverview.data.confirmed.map((task) => _mapToPayToTask(task, 'CONFIRMED')));
          
          // Map completed tasks
          completedTasks.addAll(taskOverview.data.completed.map((task) => _mapToPayToTask(task, 'COMPLETED')));

          debugPrint('Tasks fetched successfully: ${requesttasks.length} requested, ${confirmedTasks.length} confirmed, ${completedTasks.length} completed');
        } else {
          await EasyLoading.showError(taskOverview.message);
          debugPrint('API Error: ${taskOverview.message}');
        }
      } else {
        await EasyLoading.showError('Failed to fetch tasks: ${response.statusCode}');
        debugPrint('HTTP Error: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      await EasyLoading.showError('An error occurred: $e');
      debugPrint('Exception during fetchTasks: $e');
    } finally {
      await EasyLoading.dismiss();
      debugPrint('Completed fetchTasks');
    }
  }

  // Function to fetch task details by ID
  Future<void> fetchTaskDetails(String taskId) async {
    try {
      await EasyLoading.show(status: 'Loading task details...');
      debugPrint('Fetching task details for ID: $taskId');

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        await EasyLoading.showError('Authentication token is missing');
        debugPrint('Error: Authentication token is missing');
        return;
      }

      final response = await http.get(
        Uri.parse('$taskDetailsUrl/$taskId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      debugPrint('Received task details response with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        taskDetails.value = Allservicerequest.fromJson(jsonData);
        debugPrint('Task details fetched successfully for ID: $taskId');
      } else {
        await EasyLoading.showError('Failed to fetch task details: ${response.statusCode}');
        debugPrint('HTTP Error: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      await EasyLoading.showError('An error occurred: $e');
      debugPrint('Exception during fetchTaskDetails: $e');
    } finally {
      await EasyLoading.dismiss();
      debugPrint('Completed fetchTaskDetails');
    }
  }

  // Helper function to map API task to RequestServiceTask
  RequestServiceTask _mapToRequestServiceTask(Completed task, String status) {
    return RequestServiceTask(
      id: task.id,
      title: task.taskType.name,
      description: task.problemDescription,
      location: task.city,
      status: status,
      time: _formatTime(task.preferredTime),
      statusColor: status == 'PENDING' ? const Color(0xFFE9F4FF) : const Color(0xFFCCF2D8),
    );
  }

  // Helper function to map API task to PayToTask
  PayToTask _mapToPayToTask(Completed task, String status) {
    return PayToTask(
      id: task.id,
      title: task.taskType.name,
      description: task.problemDescription,
      location: task.city,
      status: status,
      date: _formatDate(task.preferredDate),
      statusColor: status == 'CONFIRMED' ? const Color(0xFFCCF2D8) : const Color(0xFFEBEBEB),
    );
  }

  // Helper function to format DateTime to time string (e.g., 11:00 AM)
  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  // Helper function to format DateTime to date string (e.g., 24 April, 2025)
  String _formatDate(DateTime dateTime) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]}, ${dateTime.year}';
  }
}