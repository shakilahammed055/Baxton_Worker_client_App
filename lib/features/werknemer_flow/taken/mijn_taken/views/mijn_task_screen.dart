import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/completed_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_completed_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_confirmed_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_payment_pending_tasks_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_upcoming_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/completed_task_card.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/show_dates.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/upcoming_task_card.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/view/widget/confirmed_task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTaskScreen extends StatelessWidget {
  const MyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingTaskController upcomingTaskController = Get.put(
      UpcomingTaskController(),
    );
    final EmployeeHomeController employeeHomeController = Get.put(
      EmployeeHomeController(),
    );

    final CompletedTaskController completedTaskController = Get.put(
      CompletedTaskController(),
    );

    // Fetch tasks when the screen is initialized
    upcomingTaskController.fetchUpcomingTasks();

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Mijn Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dates Section
                ShowDates(),
                SizedBox(height: 20),

                // Search Box and Filter Option
                Row(
                  children: [
                    // search
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.primaryWhite,

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12.0,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(IconPath.search),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // filter
                    GestureDetector(
                      onTap: () {
                        // Handle tap here
                      },
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gold3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset(IconPath.filter),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Set the Prices Section
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                  child: Text(
                    "Stel de Prijzen In",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),

                // Upcoming Tasks
                Obx(() {
                  if (upcomingTaskController.upcomingTasks.isEmpty) {
                    return Center(
                      child: Text(
                        "Geen aankomende taken.",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    );
                  }

                  // Show only first 3 tasks
                  final displayedTasks =
                      upcomingTaskController.upcomingTasks.take(3).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: displayedTasks.length,
                    itemBuilder: (context, index) {
                      return UpcomingTaskCard(
                        upcomingTask: displayedTasks[index],
                      );
                    },
                  );
                }),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AllUpcomingTaskScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bekijk alles',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Image.asset(IconPath.arrowRight6),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Showing Payment Incompleted Tasks
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                  child: Text(
                    "Betaling In Afwachting Taken",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                // ...employeeHomeController.confirmedTasks.map(
                //   (task) => ConfirmedTaskCard(employyesConfirmedTask: task),
                // ),
                // ...employeeHomeController.paymentPendingTasks.map(
                //   (task) => ConfirmedTaskCard(
                //     employyesConfirmedTask: task,
                //     isStartEnabled: false, // Disabled
                //   ),
                // ),
                ...employeeHomeController.paymentPendingTasks
                    .take(3)
                    .map(
                      (task) => ConfirmedTaskCard(
                        employyesConfirmedTask: task,
                        isStartEnabled: false, // Disabled
                      ),
                    ),

                SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AllPaymentPendingTasksScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bekijk alles',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Image.asset(IconPath.arrowRight6),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Showing Confirmed Tasks
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                  child: Text(
                    "Bevestigde Taken",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),

                // Confirmed Task Card Called here,
                //that widget is employee home screen's widget
                // ...employeeHomeController.confirmedTasks.map(
                //   (task) => ConfirmedTaskCard(employyesConfirmedTask: task),
                // ),
                // ...employeeHomeController.confirmedTasks.map(
                //   (task) => ConfirmedTaskCard(
                //     employyesConfirmedTask: task,
                //     isStartEnabled: true, // Always enabled
                //   ),
                // ),
                ...employeeHomeController.confirmedTasks
                    .take(3)
                    .map(
                      (task) => ConfirmedTaskCard(
                        employyesConfirmedTask: task,
                        isStartEnabled: true, // Enabled
                      ),
                    ),

                SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AllConfirmedTasksScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bekijk alles',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Image.asset(IconPath.arrowRight6),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Showing Completed Tasks
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                  child: Text(
                    "Voltooide Taken",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),

                // Completed Task Card Called here,
                // ...completedTaskController.completedTasks.map(
                //   (task) => CompletedTaskCard(employeesCompletedTask: task),
                // ),
                ...completedTaskController.completedTasks
                    .take(3)
                    .map(
                      (task) => CompletedTaskCard(employeesCompletedTask: task),
                    ),

                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AllCompletedTasksScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bekijk alles',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Image.asset(IconPath.arrowRight6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
