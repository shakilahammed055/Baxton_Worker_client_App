import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/view/widget/all_task_card.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/service_request_form_screen.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/set_the_price__task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WerknemerHomeScreen extends StatelessWidget {
  final EmployeeHomeController employeeHomeController =
      Get.find<EmployeeHomeController>();

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
                              Text(
                                '${employeeHomeController.userName.value}!',
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryBlack,
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
                          //controller.goToNotifications();
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

                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ServiceRequestForm());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(51),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Nieuwe taak aanmaken'),
                        SizedBox(width: 8),
                        Icon(Icons.add),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  //Price Set Button
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SetThePriceTaskScreen());
                    },
                    child: Container(
                      height: 75,
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 12,
                      //   vertical: 14,
                      // ),
                      padding: const EdgeInsets.fromLTRB(16, 18, 30, 14),

                      //margin: EdgeInsets.symmetric(horizontal: 8),
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

                          const SizedBox(width: 6),
                          Image.asset(IconPath.arrowRight),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Confirmed Task Card Called here
                  const Text(
                    'Bevestigde Taken',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...employeeHomeController.confirmedTasks.map(
                    (task) => AllTaskCard(allTask: task),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
