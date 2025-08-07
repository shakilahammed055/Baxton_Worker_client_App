import 'package:baxton/features/klant_flow/task_screen/controller/new_task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/complete_service.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/pay_to_confirm.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/request_service.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController taskController = Get.put(TaskController());
  final NewTaskController newTaskController = Get.put(NewTaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child:
              taskController.showRequestScreen.value
                  ? RequestScreen(
                    onBack: () => taskController.toggleRequestScreen(false),
                  )
                  : buildTaskContent(context),
        ),
      ),
    );
  }

  Widget buildTaskContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Mijn Taken",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            CustomIconButton(
              text: "Vraag Service Aan",
              icon: Icons.add,
              onTap: () => taskController.toggleRequestScreen(true),
              buttonColor: AppColors.buttonPrimary,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
              iconColor: Colors.white,
              isPrefix: false,
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Aangevraagde Dienst",
              style: getTextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Obx(
              () =>
                  newTaskController.requesttasks.isEmpty
                      ? Text(
                        "No requested services available",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.04,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                      : Column(
                        children:
                            newTaskController.requesttasks
                                .map(
                                  (task) => buildRequestTaskCard(
                                    context,
                                    task,
                                    newTaskController,
                                    screenWidth,
                                  ),
                                )
                                .toList(),
                      ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Betaal om te bevestigen",
              style: getTextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Obx(
              () =>
                  newTaskController.confirmedTasks.isEmpty
                      ? Text(
                        "No confirmed services available",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.04,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                      : Column(
                        children:
                            newTaskController.confirmedTasks
                                .map(
                                  (task) => buildPaytoConfirmCard(
                                    context,
                                    task,
                                    newTaskController,
                                    screenWidth,
                                    screenHeight,
                                  ),
                                )
                                .toList(),
                      ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Voltooide Dienst",
              style: getTextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Obx(
              () =>
                  newTaskController.completedTasks.isEmpty
                      ? Text(
                        "No completed services available",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.04,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                      : Column(
                        children:
                            newTaskController.completedTasks
                                .map(
                                  (task) => buildCompleteServiceCard(
                                    context,
                                    task,
                                    newTaskController,
                                    screenWidth,
                                    screenHeight,
                                  ),
                                )
                                .toList(),
                      ),
            ),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}
