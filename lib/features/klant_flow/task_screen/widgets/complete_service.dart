import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/new_task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_details_submit_screen.dart';
import 'package:flutter/material.dart';

Widget buildCompleteServiceCard(
  BuildContext context,
  PayToTask task,
  NewTaskController controller,
  double screenWidth,
  double screenHeight,
) {
  return Container(
    margin: EdgeInsets.only(bottom: screenHeight * 0.015),
    width: double.infinity,
    padding: EdgeInsets.all(screenWidth * 0.04),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: getTextStyle(
                      color: const Color(0xFF333333),
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    task.description,
                    style: getTextStyle(
                      color: const Color(0xFF666666),
                      fontSize: screenWidth * 0.04,
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
            SizedBox(width: screenWidth * 0.02),
            // Location
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF666666),
                  size: 16,
                ),
                SizedBox(width: screenWidth * 0.01),
                Text(
                  task.location,
                  style: getTextStyle(
                    color: const Color(0xFF666666),
                    fontSize: screenWidth * 0.04,
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
        SizedBox(height: screenHeight * 0.02),
        // Status, Date, and Details Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.005,
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
                      color: const Color(0xFF333333),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                      lineHeight: 12,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                SizedBox(
                  width: 100,
                  child: Text(
                    task.date,
                    style: getTextStyle(
                      color: const Color(0xFF666666),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                debugPrint(
                  'Details tapped for task: ${task.title} (ID: ${task.id})',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => TaskDetailsSubmitScreen(taskId: task.id),
                    //taskId: task.id
                  ),
                );
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
                    fontWeight: FontWeight.w600,
                    lineHeight: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
