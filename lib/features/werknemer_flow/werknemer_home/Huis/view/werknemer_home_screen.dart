// ignore_for_file: unused_element

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/notification/screens/notification_screen.dart';
import 'package:baxton/features/werknemer_flow/profile/controller/profile_editing_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/confirm_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_upcoming_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/complete_task_card.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/worker_taskExecution_screen.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/my_task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WerknemerHomeScreen extends StatelessWidget {
  final EmployeeHomeController employeeHomeController =
      Get.find<EmployeeHomeController>();
  final profileController = Get.put(ProfileSettingController());
  final ConfirmedTaskController confirmedTaskController = Get.put(
    ConfirmedTaskController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Left side: Greeting and welcome text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name Row
                          Row(
                            children: [
                              Text(
                                'Hallo',
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryBlack,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset('assets/icons/hand.png'),
                              const SizedBox(width: 8),

                              Obx(
                                () => Text(
                                  profileController.fullName.value.isNotEmpty
                                      ? profileController.fullName.value
                                      : employeeHomeController.userName.value,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Welcome Text
                          Text(
                            'Welkom terug',
                            style: getTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryBlack,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      // Notification button
                      GestureDetector(
                        onTap: () {
                          Get.to(NotificationScreen());
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(IconPath.notifications),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Price Set Red Container
                  Container(
                    height: 133,
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Color(0xFFD9A300), Color(0xFFEFC137)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: getTextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryGold,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Je hebt geweldig werk geleverd door ',
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Container(
                                    width: 38,
                                    height: 24,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryBlue,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Text(
                                      '${employeeHomeController.completedTasks}',
                                      style: getTextStyle(
                                        color: AppColors.primaryBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: ' taken \naf te ronden!'),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(IconPath.gradient),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),



                  //Price Set Button
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllUpcomingTaskScreen());
                    },
                    child: Container(
                      height: 75,
                      padding: const EdgeInsets.fromLTRB(16, 18, 30, 14),
                      decoration: BoxDecoration(
                        color: Color(0xffFF3B30).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(IconPath.checkList),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              Text(
                                'Je hebt taken zonder ',
                                style: getTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRed,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'prijzen ingesteld!',
                                style: getTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRed,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(width: 6),
                          Image.asset(IconPath.arrowRight),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Confirmed Task Card Called here
                  Text(
                    'Bevestigde Taken',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  SizedBox(height: 20),

                  Obx(() {
                    if (confirmedTaskController.confirmedTasks.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Geen bevestigde taken.'),
                        ), // No confirmed tasks
                      );
                    }

                    final displayedTasks =
                        confirmedTaskController.confirmedTasks.take(3).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayedTasks.length,
                      itemBuilder: (context, index) {
                        final task = displayedTasks[index];
                        return CompleteTaskCard(
                          task: task,
                          onPressed: () {
                            debugPrint('confirmTask id ${task.id}');
                            Get.to(
                              WorkerTaskExecutionScreen(taskId: task.id),
                              transition: Transition.leftToRight,
                            );
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCardView(MyTask task) {
    return Card(
      color: AppColors.primaryWhite,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and location
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Image.asset(IconPath.location),
                SizedBox(width: 4),
                Text(
                  task.location,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Description
            Text(
              task.shortDescription,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            SizedBox(height: 8),

            // Price
            Row(
              children: [
                Container(
                  height: 34,
                  width: 69,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      task.price,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Date/time and button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "${task.dateTime.day.toString().padLeft(2, '0')}/"
                      "${task.dateTime.month.toString().padLeft(2, '0')}/"
                      "${task.dateTime.year}    "
                      "${task.dateTime.hour.toString().padLeft(2, '0')}:"
                      "${task.dateTime.minute.toString().padLeft(2, '0')} uur",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 130.w,
                  height: 44.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.primaryBlueWithShadow;
                        }
                        return AppColors.primaryBlue;
                      }),
                      side: WidgetStateProperty.all<BorderSide>(
                        BorderSide(color: AppColors.primaryBlue),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                    ),
                    onPressed: () {
                      debugPrint('confirmTask id ${task.id}');
                      Get.to(
                        WorkerTaskExecutionScreen(taskId: task.id),
                        transition: Transition.leftToRight,
                      );
                    },
                    child: Center(
                      child: Text(
                        "Taak Starten",
                        style: GoogleFonts.roboto(fontSize: 16.sp),
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
}
