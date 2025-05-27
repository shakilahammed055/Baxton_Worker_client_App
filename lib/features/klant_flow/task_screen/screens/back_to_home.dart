import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/taakdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class BackToHome extends StatelessWidget {
  BackToHome({super.key});
  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Beoordelingsverzoek",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Betaling Bevestigd door Admin",
                    style: getTextStyle(
                      color: AppColors.primaryGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Obx(
                () => Text(
                  "${(taskController.progress.value * 100).toInt()}% Voltooid",
                  style: getTextStyle(
                    color: Color(0xff0072C3),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 32,
                      lineHeight: 14.0,
                      percent: taskController.progress.value,
                      backgroundColor: Colors.grey[300],
                      progressColor: Color(0xff0043CE),
                      barRadius: Radius.circular(10),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 20),
                    // Buttons to update progress for demo purposes
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         taskController.updateProgress(
                    //           taskController.progress.value - 0.1,
                    //         );
                    //       },
                    //       child: Text('Decrease'),
                    //     ),
                    //     SizedBox(width: 20),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         taskController.updateProgress(
                    //           taskController.progress.value + 0.1,
                    //         );
                    //       },
                    //       child: Text('Increase'),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 48),
              SizedBox(
                width: 361,
                child: Text(
                  'Uw serviceverzoek is Bevestigd – Technicus zal Binnenkort Langskomen!',
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    lineHeight: 18,
                  ),
                ),
              ),
              SizedBox(height: 48),
              CustomContinueButton(
                title: "Terug naar Startpagina",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaakdetailsScreen(),
                    ),
                  );
                },
                backgroundColor: AppColors.buttonPrimary,
                textColor: AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
