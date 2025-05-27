// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/common/widgets/custom_continue_button.dart';
// import 'package:baxton/core/common/widgets/request_textfield.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class RequestScreen extends StatelessWidget {
//   RequestScreen({super.key});

//   final RequestController requestController = Get.put(RequestController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 _buildHeader(),
//                 const SizedBox(height: 20),

//                 // Form fields
//                 _buildTextFieldSection(
//                   label: "Naam",
//                   controller: requestController.namecontroller,
//                 ),
//                 _buildTextFieldSection(
//                   label: "Telefoonnummer",
//                   controller: requestController.phonecontroller,
//                 ),
//                 _buildTextFieldSection(
//                   label: "E-mail",
//                   hintText: 'example123@gmail.com',
//                   controller: requestController.emailcontroller,
//                 ),

//                 // City and Postcode
//                 _buildCityPostcodeRow(),

//                 // Location Description
//                 _buildTextFieldSection(
//                   label: "Beschrijf Locatie",
//                   controller: requestController.describecontroller,
//                   maxLines: 3,
//                 ),

//                 // Task Type Dropdown
//                 _buildTaskTypeDropdown(),

//                 // Problem Description
//                 _buildTextFieldSection(
//                   label: "Beschrijf Probleem",
//                   controller: requestController.problemcontroller,
//                   maxLines: 3,
//                 ),

//                 // Image Section
//                 _buildImageSection(context),

//                 // Date and Time
//                 _buildDateTimeSection(context),

//                 // Submit Button
//                 const SizedBox(height: 40),
//                 CustomContinueButton(
//                   onTap: () {},
//                   title: "Verzoek Indienen",
//                   backgroundColor: AppColors.buttonPrimary,
//                   textColor: AppColors.textWhite,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Align(
//       alignment: Alignment.center,
//       child: Text(
//         "Vraag Dienst aan",
//         style: getTextStyle(
//           color: AppColors.textPrimary,
//           fontSize: 24,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildTextFieldSection({
//     required String label,
//     required TextEditingController controller,
//     String hintText = '',
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: getTextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: AppColors.textThird,
//           ),
//         ),
//         const SizedBox(height: 8),
//         RequestTextfield(
//           hintText: hintText,
//           controller: controller,
//           maxLines: maxLines,
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildCityPostcodeRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: _buildTextFieldSection(
//             label: "Stad",
//             controller: requestController.citycontroller,
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: _buildTextFieldSection(
//             label: "Postcode",
//             controller: requestController.postcodecontroller,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTaskTypeDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Taaktype",
//           style: getTextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: AppColors.textThird,
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffC0C0C0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(width: 1, color: Color(0xffC0C0C0)),
//             ),
//           ),
//           isExpanded: true,
//           items:
//               [
//                     'Schimmelinspecties en -behandelingen',
//                     'Voor- en na-inspecties van huurwoningen en nazorg',
//                     'Vochtbeheersing',
//                     'Stucwerk',
//                     'Schilderen en Coating',
//                     'Nicotinevlekkenverwijdering',
//                     'Reddersteam en Nooddienst (24/7)',
//                   ]
//                   .map(
//                     (skill) => DropdownMenuItem(
//                       value: skill,
//                       child: Text(
//                         skill,
//                         style: getTextStyle(color: AppColors.primaryGold),
//                       ),
//                     ),
//                   )
//                   .toList(),
//           onChanged: (value) {},
//           hint: Text(
//             'Select a skill',
//             style: getTextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: AppColors.textSecondary,
//             ),
//           ),
//           icon: Image.asset(IconPath.dropdown, height: 7.4, width: 12),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildImageSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Obx(
//           () => Container(
//             height: 150,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: const Color(0xffD9D9D9),
//             ),
//             child:
//                 requestController.selectedImage.value != null
//                     ? ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.file(
//                         requestController.selectedImage.value!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                     : const Icon(Icons.image_rounded, size: 50),
//           ),
//         ),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => _showImageSourceDialog(context),
//           child: Container(
//             height: 70,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: AppColors.buttonPrimary.withOpacity(.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.camera_alt, color: Color(0xff1E90FF)),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Afbeelding",
//                   style: getTextStyle(
//                     color: const Color(0xff1E90FF),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildDateTimeSection(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Time Picker
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Voorkeurs Tijd",
//                 style: getTextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textThird,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Obx(
//                 () => GestureDetector(
//                   onTap: () async {
//                     TimeOfDay? pickedTime = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     );
//                     if (pickedTime != null) {
//                       requestController.selectedTime.value = pickedTime.format(
//                         context,
//                       );
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: const Color(0xffC0C0C0)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             requestController.selectedTime.value.isEmpty
//                                 ? 'Tijd'
//                                 : requestController.selectedTime.value,
//                             style: getTextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color:
//                                   requestController.selectedTime.value.isEmpty
//                                       ? AppColors.textSecondary
//                                       : AppColors.textPrimary,
//                             ),
//                           ),
//                         ),
//                         Image.asset(
//                           IconPath.dropdown,
//                           color: AppColors.textThird,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 10),
//         // Date Picker
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Voorkeurs Datum",
//                 style: getTextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textThird,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Obx(
//                 () => GestureDetector(
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null) {
//                       requestController.selectedDate.value =
//                           "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: const Color(0xffC0C0C0)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             requestController.selectedDate.value.isEmpty
//                                 ? 'DD/MM/YY'
//                                 : requestController.selectedDate.value,
//                             style: getTextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color:
//                                   requestController.selectedDate.value.isEmpty
//                                       ? AppColors.textSecondary
//                                       : AppColors.textPrimary,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           Icons.calendar_today,
//                           size: 20,
//                           color: AppColors.textThird,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showImageSourceDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Selecteer bron"),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: const Text('Galerij'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     requestController.pickImage(ImageSource.gallery);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.camera_alt),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     requestController.pickImage(ImageSource.camera);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/common/widgets/request_textfield.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RequestScreen extends StatelessWidget {
  RequestScreen({super.key, this.onBack});

  final VoidCallback? onBack;
  final RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
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
          padding: const EdgeInsets.all(16),
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
              _buildDateTimeSection(context),
              const SizedBox(height: 40),
              CustomContinueButton(
                // onTap: () => onBack?.call(),
                onTap: () {
                  Get.to(BeoordelingsverzoekScreen());
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
        const SizedBox(height: 12),
        RequestTextfield(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
        ),
        const SizedBox(height: 16),
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
        const SizedBox(width: 10),
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
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Color(0xffC0C0C0)),
          ),
        ),
        isExpanded: true,
        dropdownColor: Colors.white, // Set your desired background color here
        items: [
          'Schimmelinspecties en -behandelingen',
          'Voor- en na-inspecties van huurwoningen en nazorg',
          'Vochtbeheersing',
          'Stucwerk',
          'Schilderen en Coating',
          'Nicotinevlekkenverwijdering',
          'Reddersteam en Nooddienst (24/7)',
        ]
            .map(
              (skill) => DropdownMenuItem(
                value: skill,
                child: Text(
                  skill,
                  style: getTextStyle(color: AppColors.textPrimary),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {},
        hint: Text(
          'Select a skill',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        icon: Image.asset(IconPath.dropdown, height: 7.4, width: 12),
      ),
      const SizedBox(height: 16),
    ],
  );
}

  Widget _buildImageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffD9D9D9),
            ),
            child:
                requestController.selectedImage.value != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        requestController.selectedImage.value!,
                        fit: BoxFit.cover,
                      ),
                    )
                    : const Icon(Icons.image_rounded, size: 50),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: Color(0xff1E90FF)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt, color: Color(0xff1E90FF)),
                const SizedBox(height: 8),
                Text(
                  "Afbeelding",
                  style: getTextStyle(
                    color: const Color(0xff1E90FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white, // set background color here
            title: const Text("Selecteer bron"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerij'),
                  onTap: () {
                    Navigator.pop(context);
                    requestController.pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    requestController.pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
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
              const SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      requestController.selectedTime.value = pickedTime.format(
                        // ignore: use_build_context_synchronously
                        context,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffC0C0C0)),
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
        const SizedBox(width: 10),
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
              const SizedBox(height: 8),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffC0C0C0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: AppColors.primaryGold,
                        ),
                        const SizedBox(
                          width: 20,
                        ), // optional spacing between icon and text
                        Expanded(
                          child: Text(
                            requestController.selectedDate.value.isEmpty
                                ? 'DD/MM/YY'
                                : requestController.selectedDate.value,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                     AppColors.textPrimary,
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
