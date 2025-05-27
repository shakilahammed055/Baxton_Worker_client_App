import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/employee_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewTaskScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TaskCreationController taskCreationController = Get.put(
    TaskCreationController(),
  );

  final EmployeeController empController = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Taakcreatie"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1st Element: Dropdown Box
              Text("Taaktype"),
              SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: taskCreationController.selectedTaskType.value,
                  items:
                      taskCreationController.taskTypes
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  //decoration: InputDecoration(labelText: "Taaktype"),
                  onChanged:
                      (val) =>
                          taskCreationController.selectedTaskType.value = val!,
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Image.asset(IconPath.dropDown2),
                ),
              ),
              const SizedBox(height: 12),

              // 2nd Element: First Text Field
              Text("Taakomschrijving"),
              SizedBox(height: 8),
              TextField(
                controller: taskCreationController.descriptionController,
                decoration: InputDecoration(
                  hintText: "Beschirijf de taak",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryBlack,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryWhite),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 12),

              // 3rd Element: Second Text Field
              Text("Naam van de klant"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.nameController,
                  decoration: InputDecoration(
                    hintText: "Virág Mercédesz",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 4th Element: 3rd Text Box (Telephone Number)
              Text("Telefoonnummer van de klant"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.phoneController,
                  decoration: InputDecoration(
                    hintText: "+123456789",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 12),

              // 5th Element: 4rd Text Box (Location)
              Text("Locatie van de klant"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.locationController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: taskCreationController.dateController,
                        decoration: InputDecoration(
                          //labelText: "Voorkeursdatum",
                          hintText: "DD/MM/YY",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                taskCreationController.preferredDate.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            taskCreationController.preferredDate.value = picked;
                            taskCreationController.dateController.text =
                                "${picked.day}/${picked.month}/${picked.year}";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: taskCreationController.timeController,
                        decoration: InputDecoration(
                          //labelText: "Voorkeurstijd",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          // Optional: Add time picker
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Toegewezen aan"),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final selected = await showDialog<Employee>(
                              context: context,
                              builder:
                                  (_) => Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 32,
                                    ),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.85,
                                      child: EmployeeSelectionView(
                                        fromPage: 'taskCreation',
                                      ),
                                    ),
                                  ),
                            );

                            if (selected != null) {
                              taskCreationController.selectedEmployee.value =
                                  selected;
                            }
                          },
                          child: Obx(() {
                            final emp = empController.selectedEmployee.value;
                            return Container(
                              height: 44,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  emp?.name ?? 'Theresa Webb',
                                  style: TextStyle(
                                    color: AppColors.primaryGold,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expertise"),
                        const SizedBox(height: 8),
                        Obx(() {
                          final emp = empController.selectedEmployee.value;
                          return Container(
                            height: 44, // custom height
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3D6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                emp?.expertise ?? 'Dak Specialist',
                                style: TextStyle(
                                  color: AppColors.primaryGold,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Create Task Button -> Task aanmaken
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //onPressed: () {},
                  onPressed: taskCreationController.createTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Taak aanmaken")],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Cancel Button -> Annuleren
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //onPressed: () {},
                  onPressed: taskCreationController.cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Annuleren")],
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
