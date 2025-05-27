import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
          // Profile Image
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(width: 10),

          // Name and Email
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Role dropdown and more button
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryWhite,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: false,
                        value: user.role,
                        icon: Image.asset(IconPath.dropDown2),
                        style: getTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                        items:
                            ['Beheerder', 'Werknemer', 'Klant']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          // Handle role update
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: Image.asset(IconPath.more),
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
}
