import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/upcoming_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/set_price_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingTaskCard extends StatelessWidget {
  final UpcomingTaskModel upcomingTask;

  UpcomingTaskCard({super.key, required this.upcomingTask});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.secondaryWhite),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Task Title
                Expanded(
                  child: Text(
                    upcomingTask.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),

                // Location
                Row(
                  children: [
                    Image.asset(IconPath.location),
                    const SizedBox(width: 4),
                    Text(
                      upcomingTask.location,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              upcomingTask.description,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
                lineHeight: 10,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Date
                Text(
                  "${upcomingTask.date}",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),

                //Time
                Text(
                  "${upcomingTask.time}",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),

                // Set Price Button
                SizedBox(
                  width: 146,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => PriceSetScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      "Prijs instellen",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
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
}
