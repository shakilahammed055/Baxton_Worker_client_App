import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/profile_screen/widgets/custom_profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                // Replace the CircleAvatar section with this:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        // CircleAvatar for the profile picture
                        Obx(
                          () => CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius:
                                  50, // Slightly smaller radius for the inner CircleAvatar
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius:
                                    50, // Even smaller for the innermost CircleAvatar
                                backgroundImage:
                                    profileController
                                            .selectedImagePath
                                            .value
                                            .isEmpty
                                        ? (profileController
                                                .logoUrl
                                                .value
                                                .isNotEmpty
                                            ? NetworkImage(
                                              profileController.logoUrl.value,
                                            )
                                            : AssetImage(IconPath.profileicon)
                                                as ImageProvider)
                                        : FileImage(
                                          File(
                                            profileController
                                                .selectedImagePath
                                                .value,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),

                        Transform.translate(
                          offset: Offset(5, 75),
                          child: GestureDetector(
                            onTap: () {
                              profileController.showImagePicker(context);
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 16,
                                color: Color(0xff1E90FF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 8),
                Text(
                  "Jakob Vaccaro",
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff212121),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "jakob@123",
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff212121),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    profileController.toggleEdit();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Bewerken",
                        style: getTextStyle(
                          color: Color(0xff1E90FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.edit, size: 15, color: Color(0xff1E90FF)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Persoonlijke Informatie",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          label: "Volledige Naam",
                          controller: profileController.fullNameController,
                          hintText: "Jakob Vaccaro",
                          enabled: profileController.isEditing.isFalse,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Information",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          label: "Telefoon",
                          controller: profileController.interviewController,
                          hintText: "+1 234-567-8901",
                          enabled: false,
                        ),
                        CustomProfileTextField(
                          label: "E-mail",
                          controller: profileController.confidenceController,
                          hintText: "johndoe@email.com ",
                          enabled: false,
                        ),
                        CustomProfileTextField(
                          label: "Locatie",
                          controller: profileController.confidenceController,
                          hintText: "Headquarters, Cityville",
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          label: "Wachtwoord",
                          controller: profileController.currentplanController,
                          hintText: "",
                          enabled: false,
                        ),
                        CustomProfileTextField(
                          label: "Melding",
                          controller: profileController.currentplanController,
                          hintText: "",
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              profileController.logout();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconPath.logout,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Uitloggen",
                                  style: getTextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSixth,
                                    fontWeight: FontWeight.w400,
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
                SizedBox(height: MediaQuery.of(context).size.width * 0.28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
