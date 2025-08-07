// ignore_for_file: use_build_context_synchronously
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/new_task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

Widget buildRequestTaskCard(
  BuildContext context,
  RequestServiceTask task,
  NewTaskController controller,
  double screenWidth,
) {
  final RequestController requestController = Get.find<RequestController>();

  return Container(
    margin: EdgeInsets.only(bottom: screenWidth * 0.03),
    width: double.infinity,
    height: screenWidth * 0.45,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Description
              SizedBox(
                width: screenWidth * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: getTextStyle(
                        color: const Color(0xFF333333),
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      task.description,
                      style: getTextStyle(
                        color: const Color(0xFF666666),
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w400,
                        lineHeight: 12,
                        letterSpacing: -0.28,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Location
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF666666),
                    size: 12,
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    task.location,
                    style: getTextStyle(
                      color: const Color(0xFF666666),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Status, Time, and Details Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenWidth * 0.01,
                    ),
                    decoration: ShapeDecoration(
                      color: task.statusColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      task.status,
                      style: getTextStyle(
                        color: const Color(0xFF1E90FF),
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w400,
                        lineHeight: 12,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    task.time,
                    style: getTextStyle(
                      color: const Color(0xFF666666),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  debugPrint('Details tapped for task: ${task.title} (ID: ${task.id})');
                  // Set requestId and fetch status
                  requestController.requestId.value = task.id;
                  await EasyLoading.show(status: 'Fetching request details...');
                  await requestController.fetchRequestStatus();
                  await EasyLoading.dismiss();
                  if (requestController.serviceRequest.value != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeoordelingsverzoekScreen(),
                      ),
                    );
                  } else {
                    EasyLoading.showError('Failed to load request details');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenWidth * 0.025,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1E90FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(62),
                    ),
                  ),
                  child: Text(
                    'Details',
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      lineHeight: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}