import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/task_request_controller2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskConfirmationView extends StatelessWidget {
  final EmployeeController empController = Get.find<EmployeeController>();
  final TaskRequestViewAllController taskRequestViewAllController =
      Get.find<TaskRequestViewAllController>();

  @override
  Widget build(BuildContext context) {
    final emp = empController.selectedEmployee.value!;
    final task = taskRequestViewAllController.detailedRequests.first;

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        title: Text("Taakdetails"),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(task.location, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 12),
            Text(
              "Lorem ipsum dolor sit amet consectetur. Laoreet massa morbi sagittis sit. Nunc et augue mattis dignissim ametluctus morbi morbi. Amet nullam sit ullamcorper molestiepulvinar vitae. Sodales amet quis sit luctus vitae pulvinaraccumsan cursus.",
            ),
            SizedBox(height: 16),
            _buildChip(task.category),
            SizedBox(height: 12),

            // Name, Location and Telephone Number
            _infoLabel("Naam van de klant", task.user),
            _infoLabel("Locatie van de klant", task.location),
            _infoLabel("Telefoonnummer van de klant", task.phoneNumber),

            // Date and Time
            Row(
              children: [
                Expanded(child: _infoLabel("Voorkeursdatum", task.date)),
                SizedBox(width: 8),
                Expanded(
                  child: _infoLabel("Voorkeurstijd", "${task.time} uur"),
                ),
              ],
            ),

            // Assigned to, and Expertise
            Row(
              children: [
                Expanded(
                  child: _infoLabel(
                    "Toegewezen aan",
                    emp.name,
                    textColor: AppColors.primaryGold,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _infoLabel(
                    "Expertise",
                    emp.expertise,
                    boxColor: AppColors.secondaryGold,
                    textColor: AppColors.primaryGold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),
            //   SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Get.snackbar(
            //           "Toegewezen",
            //           "Taak succesvol toegewezen aan ${emp.name}",
            //         );
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.primaryBlue,
            //         foregroundColor: AppColors.primaryWhite,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(51),
            //         ),
            //       ),
            //       child: Text("Doorgaan"),
            //     ),
            //   ),
            //   SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Get.snackbar(
                "Toegewezen",
                "Taak succesvol toegewezen aan ${emp.name}",
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(51),
              ),
              fixedSize: Size.fromHeight(48),
            ),
            child: Text("Doorgaan"),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      height: 54,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        border: Border.all(color: AppColors.primaryBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _infoLabel(
    String label,
    String value, {
    Color? boxColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlack,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.primaryBlack,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: boxColor ?? AppColors.primaryWhite,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryWhite),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
