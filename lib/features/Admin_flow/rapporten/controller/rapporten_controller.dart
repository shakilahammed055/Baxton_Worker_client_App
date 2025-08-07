// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:baxton/features/Admin_flow/rapporten/model/month_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RapportenController extends GetxController {
  var tasksCompleted = 120.obs;
  var tasksPending = 25.obs;
  var totalEmployees = 15.obs;
  var revenue = 10000.obs;
  var revenueGrowth = 5.34.obs;

  var totalTasks = 40.obs;
  var inBehandeling = 50.0.obs; // 50%
  var nietToegewezen = 25.0.obs; // 25%
  var voltooid = 20.0.obs; // 20%

  var averageRating = 4.5.obs; // For UI display
  var positivePercentage = 92.obs; // For UI display

  var isLoading = false.obs; // Loading state

  var selectedValue = 'Deze Maand'.obs;

  var reviews = <Map<String, dynamic>>[].obs; // RxList<Map<String, dynamic>>
  RxList<WeeklyBreakdown> weeklyBreakdown = <WeeklyBreakdown>[].obs;
  var inBehandelingCount = 0.obs;
  var nietToegewezenCount = 0.obs;
  var voltooidCount = 0.obs;
  var afgewezenCount = 0.obs;
  var geannuleerdCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize reviews with default data
    reviews.assignAll([
      <String, dynamic>{
        'name': 'Emily Parker',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 4.5,
        'reviewText':
            'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
      },
      <String, dynamic>{
        'name': 'John Doe',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 5.0,
        'reviewText':
            'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
      },
      <String, dynamic>{
        'name': 'Emily Parker',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 4.5,
        'reviewText':
            'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
      },
      <String, dynamic>{
        'name': 'John Doe',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 5.0,
        'reviewText':
            'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
      },
    ]);
    // Call API with 'thisMonth' when the screen is initialized
    fetchReportData('thisMonth');
  }

  // Update the selected value and fetch new data
  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
    // Map dropdown value to API query
    String query = newValue == 'Deze Maand' ? 'thisMonth' : 'lastMonth';
    fetchReportData(query);
  }

  // Function to fetch data from the API
  Future<void> fetchReportData(String query) async {
    try {
      debugPrint('Fetching token...');
      String? token = await AuthService.getToken();
      debugPrint(
        'Token retrieved: ${token != null ? 'Valid token' : 'Null or empty token'}',
      );

      // Handle case where token is missing
      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        await EasyLoading.showError('Authentication error: No token available');
        throw Exception('Token is not available');
      }

      isLoading.value = true; // Start loading
      debugPrint('Loading started...');

      // Prepare the URL
      final url = Uri.parse(
        'https://freepik.softvenceomega.com/ts/admin/report-analyses?query=$query',
      );
      debugPrint('URL: $url');

      // Send GET request with Authorization header
      debugPrint('Sending GET request with token...');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('Response received: ${response.statusCode}');

      // Check for response status and handle accordingly
      if (response.statusCode == 200) {
        debugPrint('Response status is OK (200). Processing data...');

        try {
          // Parse the JSON response using Month model
          final month = monthFromJson(response.body);
          debugPrint('JSON response parsed successfully: ${month.toJson()}');
          debugPrint('✅ [fetchReportData] taskTypeStatistics from API:');
          for (var stat in month.taskTypeStatistics) {
            debugPrint('🔹 ${stat.label} => ${stat.count}');
          }

          // ✅ NOW set them to your observable list
          setTaskStats(month.taskTypeStatistics);
          setWeeklyBreakdown(
            month.confirmedInvoicesLineChartData.weeklyBreakdown,
          );
          // reset
          inBehandelingCount.value = 0;
          nietToegewezenCount.value = 0;
          voltooidCount.value = 0;
          afgewezenCount.value = 0;
          geannuleerdCount.value = 0;

          for (var statusItem in month.taskStatus) {
            switch (statusItem.status) {
              case 'CONFIRMED': // In Behandeling
                inBehandelingCount.value = statusItem.count.status;
                break;
              case 'ASSIGNED': // Niet Toegewezen
                nietToegewezenCount.value = statusItem.count.status;
                break;
              case 'COMPLETED': // Voltooid
                voltooidCount.value = statusItem.count.status;
                break;
              case 'REJECT': // Afgewezen
                afgewezenCount.value = statusItem.count.status;
                break;
              case 'CANCELLED': // Geannuleerd
                geannuleerdCount.value = statusItem.count.status;
                break;
            }
          }

          // Update observables with data from Month model
          tasksCompleted.value =
              month.monthlyCompletionRate.totalCompletedTasks;
          debugPrint('tasksCompleted: ${tasksCompleted.value}');

          tasksPending.value = month.pendingServiceRequestsCount;
          debugPrint('tasksPending: ${tasksPending.value}');

          totalEmployees.value = month.totalWorkerCount;
          debugPrint('totalEmployees: ${totalEmployees.value}');

          revenue.value = month.confirmedInvoicesLineChartData.totalRevenue;
          debugPrint('revenue: ${revenue.value}');

          revenueGrowth.value =
              month.monthlyTurnoverReport.progressRate.toDouble();
          debugPrint('revenueGrowth: ${revenueGrowth.value}');

          totalTasks.value = month.monthlyCompletionRate.currentMonth;
          debugPrint('totalTasks: ${totalTasks.value}');

          // Update rating and positive percentage for UI
          averageRating.value = month.averageRatingAndReviews.averageRating;
          debugPrint('averageRating: ${averageRating.value}');

          positivePercentage.value =
              month.averageRatingAndReviews.positivePercentage;
          debugPrint('positivePercentage: ${positivePercentage.value}');

          // Calculate task status percentages
          int totalStatusCount = month.taskStatus.fold(
            0,
            (sum, status) => sum + status.count.status,
          );

          if (totalStatusCount > 0) {
            month.taskStatus.forEach((status) {
              double percentage =
                  (status.count.status / totalStatusCount) * 100;
              if (status.status.toLowerCase() == 'in behandeling') {
                inBehandeling.value = percentage;
                debugPrint('inBehandeling: ${inBehandeling.value}');
              } else if (status.status.toLowerCase() == 'niet toegewezen') {
                nietToegewezen.value = percentage;
                debugPrint('nietToegewezen: ${nietToegewezen.value}');
              } else if (status.status.toLowerCase() == 'voltooid') {
                voltooid.value = percentage;
                debugPrint('voltooid: ${voltooid.value}');
              }
            });
          }

          // Update reviews from averageRatingAndReviews.firstThreeReviews
          if (month.averageRatingAndReviews.firstThreeReviews.isNotEmpty) {
            reviews.assignAll(
              month.averageRatingAndReviews.firstThreeReviews.map((review) {
                return <String, dynamic>{
                  'name': review.clientProfile.userName,
                  'profileImage':
                      review.clientProfile.profilePic.url.isNotEmpty
                          ? review.clientProfile.profilePic.url
                          : 'assets/icons/profilepic.png',
                  'rating': review.rating.toDouble(),
                  'reviewText': review.review,
                };
              }).toList(),
            );
            debugPrint('reviews: ${reviews.toString()}');
          } else {
            debugPrint('No reviews available from API');
            reviews.clear();
          }
        } catch (jsonError) {
          // Handle JSON parsing errors
          debugPrint('Error parsing JSON response: $jsonError');
          await EasyLoading.showError('Failed to parse data from the server');
        }
      } else {
        // Handle different HTTP status codes
        debugPrint(
          'Response status code is not OK. Status code: ${response.statusCode}',
        );
        String errorMessage =
            'Failed to fetch report data: ${response.statusCode}';

        if (response.statusCode == 401) {
          errorMessage = 'Unauthorized: Invalid or expired token';
          // Optionally redirect to login screen
          // Get.offAllNamed('/login');
        } else if (response.statusCode == 404) {
          errorMessage = 'Resource not found';
        } else if (response.statusCode == 500) {
          errorMessage = 'Internal server error';
        }
        await EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      // Handle general errors
      debugPrint('An error occurred: $e');
      await EasyLoading.showError('An error occurred: $e');
    } finally {
      isLoading.value = false; // Stop loading
      debugPrint('Loading finished');
    }
  }

  // Example: call this after fetching your JSON
  void loadData(Map<String, dynamic> json) {
    final list = json['taskTypeStatistics'] as List<dynamic>;
    taskStats.value = list.map((e) => TaskTypeStatistic.fromJson(e)).toList();
    isLoading.value = false;
  }

  RxList<TaskTypeStatistic> taskStats = <TaskTypeStatistic>[].obs;

  /// ✅ fixed color palette for each bar
  final List<Color> barColors = [
    const Color(0xFF62B2FD),
    const Color(0xFF9BDFC4),
    const Color(0xFFF99BAB),
    const Color(0xFFFFB44F),
    const Color(0xFF9F97F7),
    const Color(0xFFB8C4CE),
    const Color(0xFF0D7FE9),
  ];

  void setTaskStats(List<TaskTypeStatistic> stats) {
    taskStats.assignAll(stats);
    debugPrint('✅ taskStats length: ${taskStats.length}');
    for (var stat in taskStats) {
      debugPrint('➡️ Bar Data: ${stat.label} = ${stat.count}');
    }
  }

  int get maxCount {
    if (taskStats.isEmpty) return 0;
    int maxVal = taskStats.map((e) => e.count).reduce((a, b) => a > b ? a : b);
    return maxVal;
  }

  void setWeeklyBreakdown(List<WeeklyBreakdown> breakdown) {
    weeklyBreakdown.assignAll(breakdown);
    debugPrint('✅ weeklyBreakdown count: ${weeklyBreakdown.length}');
    for (var wb in weeklyBreakdown) {
      debugPrint(
        'Week Start: ${wb.weekStart}, Week End: ${wb.weekEnd}, Amount: ${wb.totalAmount}, Invoices: ${wb.invoiceCount}',
      );
    }
  }
}
