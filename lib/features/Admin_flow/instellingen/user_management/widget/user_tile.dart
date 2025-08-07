// ignore_for_file: unused_local_variable

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final dropdownValue = userTypeToDutch(user.userType);
    final validRoles = ['Beheerder', 'Werknemer', 'Klant'];
    final selectedValue =
        validRoles.contains(dropdownValue) ? dropdownValue : validRoles.first;

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Profile Image with fallback
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundImage: _getAvatarImage(user),
          ),
          const SizedBox(width: 10),

          // ✅ Name and Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),

                const SizedBox(height: 6),
                Text(
                  user.email,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
              ],
            ),
          ),

          // ✅ Role dropdown and more button
          SizedBox(
            width: screenWidth * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Dropdown
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryWhite,
                    ),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        value: selectedValue,
                        icon: Image.asset(IconPath.dropDown2, width: 16),
                        style: getTextStyle(
                          lineHeight: 12,
                          fontSize: screenWidth * 0.032,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                        items:
                            ['Beheerder', 'Werknemer', 'Klant']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(
                                      role,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            final newUserType = dutchToUserType(value);
                          }
                        },
                        dropdownColor: AppColors.primaryWhite,
                        menuMaxHeight: 200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // More Button
                IconButton(
                  icon: Image.asset(IconPath.more, width: 30),
                  onPressed: () {
                    // Handle more options
                  },
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getAvatarImage(UserModel user) {
    return const AssetImage('assets/images/user.png');
  }

  String userTypeToDutch(String? userType) {
    if (userType == null) return 'Onbekend';
    switch (userType.toUpperCase()) {
      case 'ADMIN':
        return 'Beheerder';
      case 'WORKER':
        return 'Werknemer';
      case 'CLIENT':
        return 'Klant';
      default:
        return 'Onbekend';
    }
  }

  String dutchToUserType(String dutchRole) {
    switch (dutchRole) {
      case 'Beheerder':
        return 'ADMIN';
      case 'Werknemer':
        return 'WORKER';
      case 'Klant':
        return 'CLIENT';
      default:
        return '';
    }
  }
}
