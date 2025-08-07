// full_service_request_screen.dart
import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/controller/service_request_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_dropdown_field.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ServiceRequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ServiceRequestController serviceRequestController = Get.put(
    ServiceRequestController(),
  );

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
          'Vraag Dienst aan',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Naam',
                height: 41,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.name = val,
                    ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Telefoonnummer',
                height: 41,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.phone = val,
                    ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'E-mail',
                height: 41,
                initial: 'example123@gmail.com',
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.email = val,
                    ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => MyDropdown(
                        height: 41,
                        label: 'Stad',
                        value: serviceRequestController.selectedCity.value,
                        items: serviceRequestController.cities,
                        onChanged:
                            (val) =>
                                serviceRequestController.selectedCity.value =
                                    val!,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomTextField(
                      label: 'Postcode',
                      height: 41,
                      onChanged:
                          (val) => serviceRequestController.request.update(
                            (r) => r?.postalCode = val,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Beschrijf Locatie',
                maxLines: 3,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.locationDesc = val,
                    ),
              ),
              SizedBox(height: 16),
              Text("Taaktype"),
              SizedBox(height: 8),
              Obx(
                () => MyDropdown(
                  height: 41,
                  label: '',
                  value: serviceRequestController.selectedTaskType.value,
                  items: serviceRequestController.taskTypes,
                  onChanged:
                      (val) =>
                          serviceRequestController.selectedTaskType.value =
                              val!,
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Beschrijf Probleem',
                maxLines: 3,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.problemDesc = val,
                    ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: serviceRequestController.pickImage,
                child: Obx(
                  () => Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        serviceRequestController
                                .selectedImagePath
                                .value
                                .isNotEmpty
                            ? Image.file(
                              File(
                                serviceRequestController
                                    .selectedImagePath
                                    .value,
                              ),
                              fit: BoxFit.cover,
                            )
                            : Image.asset(IconPath.photoUpload),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Voorkeurs Tijd'),
                        SizedBox(height: 8),
                        Obx(
                          () => MyDropdown(
                            height: 41,
                            label: '',
                            value: serviceRequestController.selectedTime.value,
                            items: ['Ochtend', 'Middag', 'Avond'],
                            onChanged:
                                (val) => serviceRequestController.setTime(val!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Voorkeurs Datum'),
                        SizedBox(height: 8),
                        Obx(() {
                          final selectedDate =
                              serviceRequestController.selectedDate.value;
                          final controller = TextEditingController(
                            text:
                                selectedDate != null
                                    ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate)
                                    : '',
                          );
                          return SizedBox(
                            height: 41,
                            child: TextFormField(
                              readOnly: true,
                              controller: controller,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  serviceRequestController.setDate(date);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'DD/MM/YYYY',
                                prefixIcon: Image.asset(
                                  IconPath.calendarMonth,
                                  color: AppColors.primaryGold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.formFieldBorderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.formFieldBorderColor,
                                  ),
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
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await serviceRequestController.submitRequest();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(63),
                  ),
                ),
                child: const Text('Create Task'),
              ),
              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
