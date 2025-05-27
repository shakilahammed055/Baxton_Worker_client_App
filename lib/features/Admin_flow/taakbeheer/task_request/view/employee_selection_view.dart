import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
// ignore: unused_import
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_details_form_submission_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeSelectionView extends StatelessWidget {
  final String fromPage;
  final EmployeeController controller = Get.put(EmployeeController());
  EmployeeSelectionView({required this.fromPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        title: Text("Taakverzoekdetails"),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _selectedHeader(),
            SizedBox(height: 24),
            _searchAndFilterBar(),
            SizedBox(height: 12),
            Expanded(child: Obx(() => _employeeList())),
            SizedBox(height: 16),

            Obx(() {
              final isEnabled = controller.selectedEmployee.value != null;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      isEnabled
                          ? () {
                            if (fromPage == 'taskRequest') {
                              Get.to(() => TaskConfirmationView());
                            } else if (fromPage == 'taskCreation') {
                              Get.back(); // or do something else
                            }
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                    fixedSize: Size.fromHeight(48),
                    padding: EdgeInsets.all(10),
                  ),
                  child: Text("Toewijzen"),
                ),
              );
            }),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _selectedHeader() {
    return Obx(() {
      final emp = controller.selectedEmployee.value;
      return Row(
        children: [
          Expanded(
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              label: Text(
                emp?.name ?? "Theresa Webb",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGold,
                ), // Text color
              ),
              backgroundColor: AppColors.primaryWhite,
            ),
          ),
          Expanded(
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              label: Text(
                emp?.expertise ?? "Dakspecialist",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGold,
                ),
              ),
              backgroundColor: AppColors.secondaryGold,
            ),
          ),
        ],
      );
    });
  }

  // Search Box and Filter Option
  Widget _searchAndFilterBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: controller.searchEmployee,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              // Search Icon
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(IconPath.search),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor2),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          // icon: const Icon(Icons.filter_alt_outlined),
          icon: Image.asset(IconPath.filter),
          onPressed: () {
            //dummy filter modal or logic
            controller.filterByExpertise("Dakspecialist");
          },
        ),
      ],
    );
  }

  // Employee List View
  Widget _employeeList() {
    return ListView.builder(
      itemCount: controller.filteredEmployees.length,
      itemBuilder: (context, index) {
        final emp = controller.filteredEmployees[index];
        return Obx(() {
          final isSelected =
              emp.name == controller.selectedEmployee.value?.name;
          return ListTile(
            tileColor: AppColors.primaryWhite,
            leading: CircleAvatar(backgroundImage: NetworkImage(emp.imageUrl)),
            title: Text(
              emp.name,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryBlack,
              ),
            ),
            subtitle: Text(
              emp.expertise,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
            selected: isSelected,
            //selectedTileColor: AppColors.primaryWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              ),
            ),
            onTap: () => controller.selectEmployee(emp),
          );
        });
      },
    );
  }
}
