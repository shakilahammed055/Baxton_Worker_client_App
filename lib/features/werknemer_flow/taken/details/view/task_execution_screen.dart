import 'dart:io';
import 'dart:math';

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/details/controller/task_execution_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/widget/checklist_item_widget.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/client_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskExecutionScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final TaskExecutionController taskExecutionController = Get.put(
    TaskExecutionController(),
  );
  final ClientInfoController clientInfoController =
      Get.find<ClientInfoController>();

  late final DateTime dateTime;
  late final String dateStr;
  late final String timeStr;

  TaskExecutionScreen({super.key}) {
    dateTime =
        clientInfoController.clientInfo.isNotEmpty
            ? clientInfoController.clientInfo.first.dateTime
            : DateTime.now();

    dateStr = DateFormat('dd/MM/yyyy').format(dateTime);
    timeStr = DateFormat('HH:mm').format(dateTime);
  }

  TaskExecutionScreen.namedConstructor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        title: Text(
          "Taakdetails",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Client Information
            Container(
              width: double.infinity,
              height: 231,
              //padding: const EdgeInsets.all(16),
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondaryWhite),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Klanteninformatie',
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ClientInfoCard(
                    label: 'Naam',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerName ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(
                    label: 'Locatie',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerAddress ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(
                    label: 'Telefoonnummer',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerPhone ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(label: 'Gewenste datum', value: dateStr),
                  SizedBox(height: 12),
                  ClientInfoCard(label: 'Gewenste tijd', value: '$timeStr uur'),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Price Box
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryGold,
                border: Border.all(color: AppColors.secondaryWhite),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                //'\$${controller.workPrice.value}',
                "\$5000",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryGold,
                ),
              ),
            ),

            // Show list of added work items
            Obx(
              () => Column(
                children:
                    taskExecutionController.workItems.map((item) {
                      return Container(
                        width: double.infinity,
                        color: AppColors.secondaryGold,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryBlack,
                              ),
                            ),
                            Text(
                              '\$${item['price']}',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => showDialogWork(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryBlue,
                foregroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                side: BorderSide(color: AppColors.secondaryBlue),
              ),
              child: Text(
                'Toevoegen   +',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Progress Bar
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Jouw voortgang',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey4,
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Column(
                children: [
                  Text(
                    '${(taskExecutionController.progress * 100).toStringAsFixed(0)}% Voltooid',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryCyan,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 296,
                    child: LinearProgressIndicator(
                      value: taskExecutionController.progress,
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 12,
                      color: AppColors.progressBarBlue,
                      backgroundColor: AppColors.progressbarGrey,
                      stopIndicatorColor: AppColors.primaryGold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Checklist Button
            Text(
              "TaakChecklist",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showDialogChecklist(context),
              child: const Text('Checklist +'),
            ),
            const SizedBox(height: 20),

            Obx(
              () => Column(
                children:
                    taskExecutionController.checkList
                        .asMap()
                        .entries
                        .map(
                          (e) => ChecklistItemWidget(
                            item: e.value,
                            onChanged:
                                (val) => taskExecutionController.toggleCheck(
                                  e.key,
                                  val,
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 40),

            // Camera

            // Camera Section UI with two image inputs side by side
            Row(
              children: [
                // First Image Box: "Maak foto na afloop"
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: taskExecutionController.captureImageAfter,
                        // Camera container
                        child: Container(
                          width: 173,
                          height: 70,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBlue,
                            border: Border.all(color: AppColors.primaryBlue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Image.asset(IconPath.camera),
                              const SizedBox(height: 12),
                              Text(
                                "Maak foto na afloop",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryBlue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // photo container
                      Obx(
                        () => Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child:
                              taskExecutionController
                                      .capturedImagePathAfter
                                      .value
                                      .isNotEmpty
                                  ? Image.file(
                                    File(
                                      taskExecutionController
                                          .capturedImagePathAfter
                                          .value,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                  : Image.asset(IconPath.photoUpload),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Second Image Box: "Na foto"
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: taskExecutionController.captureImageBefore,
                        // camera Container
                        child: Container(
                          width: 173,
                          height: 70,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBlue,
                            border: Border.all(color: AppColors.primaryBlue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Image.asset(IconPath.camera),
                              SizedBox(height: 4),

                              Text(
                                "Na foto",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryBlue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // photo Container
                      Obx(
                        () => Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child:
                              taskExecutionController
                                      .capturedImagePathBefore
                                      .value
                                      .isNotEmpty
                                  ? Image.file(
                                    File(
                                      taskExecutionController
                                          .capturedImagePathBefore
                                          .value,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                  : Image.asset(IconPath.photoUpload),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "Handtekening van de klant",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  backgroundColor: AppColors.secondaryWhite,
                  side: const BorderSide(color: AppColors.formFieldBorderColor),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(IconPath.pen),
                    Text(
                      "Vraag om de handtekening van de klant",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Note",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              controller: _textController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      side: BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Taak Pauzeren',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle second button press
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      backgroundColor: AppColors.primaryBlue,
                      side: const BorderSide(
                        color: AppColors.formFieldBorderColor,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                    ),

                    child: Text('Taak voltooien'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Work Dialog Function
  void showDialogWork(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text(
          'Prijs instellen',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryBlack,
          ),
        ),
        backgroundColor: AppColors.primaryWhite,
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(hintText: 'Dient'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(hintText: '0.00'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                  ),
                  onPressed: () {
                    taskExecutionController.addWorkItem(
                      nameController.text,
                      priceController.text,
                    );
                    Get.back();
                  },
                  child: const Text('Wijzigingen opslaan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Checklist Dialog Function
  void showDialogChecklist(BuildContext context) {
    final taskController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Checklist Toevoegen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(hintText: 'Checklist item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                taskExecutionController.addCheckItem(taskController.text);
                Get.back();
              },
              child: const Text('Toevoegen'),
            ),
          ],
        ),
      ),
    );
  }
}
