

import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/job_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/service_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JobController extends GetxController {
  var jobList = <Job>[].obs;
  var requestedList = <ServiceRequest>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('JobController onInit called');
    
  }

  Future<List<ServiceRequest>> fetchServiceRequestsForStatus(String status) async {
    final url = Uri.parse('https://freepik.softvenceomega.com/ts/service-request/get-all-client-service-request?take=10&skip=0&taskType=$status');
    String? token = await AuthService.getToken();

    if (token == null || token.isEmpty) {
      errorMessage.value = 'Authentication token is missing';
      await EasyLoading.showError(errorMessage.value);
      return [];
    }

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      debugPrint('fetchServiceRequestsForStatus ($status) Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          final serviceResponse = ServiceResponse.fromJson(data);
          debugPrint('Service Requests for $status: ${serviceResponse.data.map((e) => e.toJson()).toList()}');
          return serviceResponse.data;
        } else {
          throw Exception('Failed to load service requests: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load service requests: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Error fetching service requests for $status: $e';
      debugPrint('Error: $errorMessage');
      debugPrint('Stack trace: $stackTrace');
      await EasyLoading.showError(errorMessage.value);
      return [];
    }
  }


  List<Job> getJobs() {
    return jobList.toList();
  }

  List<ServiceRequest> getRequestedServices() {
    debugPrint('Requested Services: ${requestedList.map((e) => e.toJson()).toList()}');
    return requestedList.toList();
  }


}


