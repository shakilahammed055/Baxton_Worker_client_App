import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/employee_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_request_detail_model.dart';
import 'package:get/get.dart';

class TaskRequestDetailView extends StatelessWidget {
  final TaskRequestDetail task;

  TaskRequestDetailView({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Taakverzoekdetails"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              task.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Location
            Text(
              task.location,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            //Description
            Text(
              "Lorem ipsum dolor sit amet consectetur. Laoreet massa morbi sagittis sit. "
              "Nunc et augue mattis dignissim amet luctus morbi morbi. Amet nullam sit "
              "ullamcorper molestie pulvinar vitae.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 20),

            // Category
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryBlue),
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondaryBlue,
              ),
              child: Center(
                child: Text(
                  task.category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Form details
            _buildLabel("Naam van de klant"),
            _buildTextField(task.user),

            _buildLabel("Locatie van de klant"),
            _buildTextField(task.location),

            _buildLabel("Telefoonnummer van de klant"),
            _buildTextField(task.phoneNumber),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Gewenste datum"),
                      _buildTextField(task.date),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Gewenste tijd"),
                      _buildTextField(task.time),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // handle decline
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryBlue),
                      foregroundColor: AppColors.primaryBlue,
                      fixedSize: Size(173, 48),
                    ),
                    child: Text("Afwijzen"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => EmployeeSelectionView(fromPage: 'taskRequest'),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(51),
                        ),
                        fixedSize: Size(173, 48),
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                      ),

                      child: Text("Accepteren"),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryBlack,
        ),
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBlack,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: AppColors.primaryWhite,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryWhite),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
