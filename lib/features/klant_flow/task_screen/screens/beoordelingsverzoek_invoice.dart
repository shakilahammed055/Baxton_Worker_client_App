import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/back_to_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class BetalingsbeheerInvoiceScreen extends StatelessWidget {
  BetalingsbeheerInvoiceScreen({super.key});
  final TaskCreationController taskCreationController = Get.put(
    TaskCreationController(),
  );
  BetalingsbeheerController betalingsbeheerController = Get.put(
    BetalingsbeheerController(),
  );
  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Betalingsbeheer",
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
                    "Factuur Genereren",
                    style: getTextStyle(
                      color: AppColors.primaryGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFBF6E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 148,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Color(0xffF3E2B0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(IconPath.logo1, height: 42, width: 119),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "adres:",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryGold,
                                ),
                              ),
                              Text(
                                " 123 Property Lane, Cityville, NL",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5B4400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Telefoon:",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryGold,
                                ),
                              ),
                              Text(
                                " +31 123 456 789",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5B4400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "E-mail:",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryGold,
                                ),
                              ),
                              Text(
                                " info@baxton.nl",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5B4400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 95,
                                child: Text(
                                  'Invoice Number: INV-2025-001',
                                  style: getTextStyle(
                                   color: Color(0xff5B4400),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    lineHeight: 9
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    'Datum uitgegeven: 14 april 2025',
                                    textAlign: TextAlign.center,
                                    style: getTextStyle(
                                     color: Color(0xff5B4400),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      lineHeight: 8
                                    ),
                                  ),
                                  Text(
                                    'Vervaldatum: 28 april 2025',
                                    textAlign: TextAlign.center,
                                    style: getTextStyle(
                                     color: Color(0xff5B4400),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 225,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                Text(
                                  'Klantinformatie',
                                  style: getTextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Naam',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'Samantha Green',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Telefoonnummer',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '+001 234 567',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'E-mail',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'example123@gmail.com',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Stad',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'London',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Postcode',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '1243',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 114,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                Text(
                                  'Medewerkerinformatie',
                                  style: getTextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,

                                    fontWeight: FontWeight.w500,
                                    lineHeight: 10,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Naam',
                                      style: TextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'Samantha Green',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 1.30,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Telefoonnummer',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '+001 234 567',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 204,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                Text(
                                  'Servicedetails',
                                  style: getTextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Schimmelinspectie',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '\$500',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Schilderen & Coaten',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '\$1000',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Nicotinevlekkenverwijdering',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '\$3500',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 305,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: const Color(0xFFEBEBEB),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Totaal',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      '\$5000',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 151,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 27,
                              children: [
                                Text(
                                  'Betalingsdetails',
                                  style: getTextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Banknaam',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'Bank of Netherlands',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  spacing: 4,
                                  children: [
                                    Text(
                                      'IBAN',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'NL20BANK1234567890',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  spacing: 4,
                                  children: [
                                    Text(
                                      'BIC/SWIFT',
                                      style: getTextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w400,

                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    Text(
                                      'BANKNL2A',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xFF1E90FF),
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 172,
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.all(15),
                            decoration: ShapeDecoration(
                              color: const Color(
                                0x33FF3B30,
                              ).withValues(alpha: 0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Bij het doen van de betaling, gelieve het factuurnummer (gevonden bovenaan dit document) als betalingsreferentie of beschrijving op te nemen. Dit zorgt ervoor dat uw betaling correct aan uw taak en factuur wordt gekoppeld.',
                              textAlign: TextAlign.center,
                              style: getTextStyle(
                                color: const Color(0xFFFF3B30),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                lineHeight: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CustomContinueButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BackToHome(),
                    ),
                  );
                },
                title: "Betalen",
                backgroundColor: AppColors.buttonPrimary,
                textColor: AppColors.textWhite,
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF1E90FF),
                      ),
                      borderRadius: BorderRadius.circular(62),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Image.asset(IconPath.downloaddocument),
                      ),
                      Text(
                        'Factuur Downloaden',
                        style: TextStyle(
                          color: const Color(0xFF1E90FF),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          height: 1.20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
