// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/common/widgets/request_textfield.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_type_model.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RequestScreen extends StatelessWidget {
  RequestScreen({super.key, this.onBack});

  final VoidCallback? onBack;
  final RequestController requestController = Get.put(RequestController());
  final TaskCreationController taskCreationController = Get.put(
    TaskCreationController(),
  );

  String _formatTaskTypeName(String name) {
    if (name.isEmpty) return name;
    String formatted = name.toLowerCase().replaceAll('_', ' ');
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: onBack ?? () => Get.back(),
        ),
        title: Text(
          "Vraag Dienst aan",
          style: getTextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldSection(
                label: "Naam",
                controller: requestController.namecontroller,
              ),
              _buildTextFieldSection(
                label: "Telefoonnummer",
                controller: requestController.phonecontroller,
              ),
              _buildTextFieldSection(
                label: "E-mail",
                hintText: 'example123@gmail.com',
                controller: requestController.emailcontroller,
              ),
              _buildCityPostcodeRow(),
              _buildTextFieldSection(
                label: "Beschrijf Locatie",
                controller: requestController.describecontroller,
                maxLines: 3,
              ),
              _buildTaskTypeDropdown(),
              _buildTextFieldSection(
                label: "Beschrijf Probleem",
                controller: requestController.problemcontroller,
                maxLines: 3,
              ),
              _buildImageSection(context),
              SizedBox(height: 16.h),
              _buildDateTimeSection(context),
              SizedBox(height: 40),
              CustomContinueButton(
                onTap: () async {
                  // Find taskTypeId based on selected task type
                  String? taskTypeId;
                  if (taskCreationController.selectedTaskType.value != null) {
                    final selectedTask = taskCreationController.taskTypes
                        .firstWhere(
                          (taskType) =>
                              taskType.name ==
                              taskCreationController.selectedTaskType.value,
                          orElse: () => TaskType(id: '', name: ''),
                        );
                    taskTypeId = selectedTask.id;
                    debugPrint(
                      'Submitting request with Task Type ID: $taskTypeId',
                    );
                  }

                  if (taskTypeId == null || taskTypeId.isEmpty) {
                    Get.snackbar('Error', 'Please select a task type');
                    return;
                  }

                  // Submit the request
                  bool success = await requestController.submitRequest(
                    taskTypeId,
                  );
                  if (success) {
                    Get.to(() => BeoordelingsverzoekScreen());
                  }
                },
                title: "Verzoek Indienen",
                backgroundColor: AppColors.buttonPrimary,
                textColor: AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldSection({
    required String label,
    required TextEditingController controller,
    String hintText = '',
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textThird,
          ),
        ),
        SizedBox(height: 12),
        RequestTextfield(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCityPostcodeRow() {
    return Row(
      children: [
        Expanded(
          child: _buildTextFieldSection(
            label: "Stad",
            controller: requestController.citycontroller,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildTextFieldSection(
            label: "Postcode",
            controller: requestController.postcodecontroller,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Taaktype",
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textThird,
          ),
        ),
        SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: taskCreationController.selectedTaskType.value,
            items:
                taskCreationController.taskTypes.isNotEmpty
                    ? taskCreationController.taskTypes
                        .map<DropdownMenuItem<String>>((TaskType taskType) {
                          return DropdownMenuItem<String>(
                            value: taskType.name,
                            child: Text(_formatTaskTypeName(taskType.name)),
                          );
                        })
                        .toList()
                    : [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text('Geen taaktypen beschikbaar'),
                      ),
                    ],
            onChanged: (String? val) {
              taskCreationController.selectedTaskType.value = val;
              // Print taskTypeId when a task type is selected
              if (val != null) {
                final selectedTask = taskCreationController.taskTypes
                    .firstWhere(
                      (taskType) => taskType.name == val,
                      orElse: () => TaskType(id: '', name: ''),
                    );
                debugPrint('Selected Task Type ID: ${selectedTask.id}');
              }
            },
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
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Afbeeldingen toevoegen',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => requestController.pickImagesWithCaptions(context),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: const Color(0xff1E90FF)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  color: Color(0xff1E90FF),
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  "Afbeelding",
                  style: getTextStyle(
                    color: const Color(0xff1E90FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Reactive section: show placeholder or image grid
        Obx(() {
          final images = requestController.selectedImages;
          final captions = requestController.imageCaptions;

          if (images.isEmpty) {
            // Show placeholder when no images are selected
            return GestureDetector(
              onTap: () => requestController.pickImagesWithCaptions(context),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconPath.photoUpload,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Klik om afbeeldingen toe te voegen",
                      style: getTextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show image grid when images are selected
          return Obx(() {
            final showAllImages = requestController.showAllImages;
            final displayCount =
                showAllImages.value
                    ? images.length
                    : (images.length > 2 ? 2 : images.length);

            return Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkTextColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.file(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGold,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              captions[index],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primaryBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                if (images.length > 2) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      requestController.toggleShowAllImages();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        showAllImages.value ? "Close" : "Bekijk alle foto’s",
                        style: getTextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          });
        }),
      ],
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Voorkeurs Tijd",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textThird,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      requestController.selectedTime.value = pickedTime.format(
                        context,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC0C0C0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            requestController.selectedTime.value.isEmpty
                                ? ''
                                : requestController.selectedTime.value,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  requestController.selectedTime.value.isEmpty
                                      ? AppColors.textSecondary
                                      : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Image.asset(
                          IconPath.dropdown,
                          color: AppColors.buttonPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Voorkeurs Datum",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textThird,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      requestController.selectedDate.value =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC0C0C0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: AppColors.primaryGold,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            requestController.selectedDate.value.isEmpty
                                ? 'DD/MM/YY'
                                : requestController.selectedDate.value,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
