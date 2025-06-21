import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_overview_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/all_tasks_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/stat_card.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/task_request_card.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/views/task_creation_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_view_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagerScreen extends StatelessWidget {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller Instances
  final TaskOverviewController taskOverviewController = Get.put(
    TaskOverviewController(),
  );
  final TaskRequestController taskRequestController = Get.put(
    TaskRequestController(),
  );

  TaskManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Taakbeheer"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Taakoverzicht",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16),

            // Calling StatCard Widgets
            Obx(() {
              final stats = taskOverviewController.stats.value;
              final screenWidth = MediaQuery.of(context).size.width;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  StatCard(
                    iconPath: IconPath.assignedTask,
                    title: "Toegewezen taken",
                    count: stats.assigned,
                    countTextStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  StatCard(
                    iconPath: IconPath.inProgress,
                    title: "In uitvoering",
                    count: stats.inProgress,
                    countTextStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  StatCard(
                    iconPath: IconPath.completed,
                    title: "Voltooid",
                    count: stats.completed,
                    countTextStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  StatCard(
                    iconPath: IconPath.tooLate,
                    title: "Te laat",
                    count: stats.overdue,
                    countTextStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryRed,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllTasksScreen());
                    },
                    child: StatCard(
                      iconPath: IconPath.totalNumberOfTasks,
                      title: "Totaal aantal takennnn",
                      count: stats.total,
                      width:
                          screenWidth -
                          36, // Adjusted for 18px padding on both sides
                      crossAxisAlignment: CrossAxisAlignment.center,

                      countTextStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: 30),

            // Unassigned Tasks Button
            Obx(
              () => SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryBlue,
                    foregroundColor: AppColors.primaryBlack,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),

                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          "${taskOverviewController.stats.value.unassigned}",
                          style: getTextStyle(
                            fontWeight: FontWeight.w600,

                            fontSize: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text("Niet-toegewezen taken"),
                      SizedBox(width: 40),
                      Image.asset(IconPath.arrowRight2),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 12),

            // Create New task Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => CreateNewTaskScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nieuwe taak aanmaken"),
                    SizedBox(width: 8),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Taakverzoeken",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => TaskRequestListView());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Bekijk alles ",
                          style: getTextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(IconPath.arrowRight3),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Calling Task_Request_Card Widgets
            Obx(
              () => Column(
                children:
                    // ignore: invalid_use_of_protected_member
                    taskRequestController.taskRequests.value
                        .map((req) => TaskRequestCard(req: req))
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
