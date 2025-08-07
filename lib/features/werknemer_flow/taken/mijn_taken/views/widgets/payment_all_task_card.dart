import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/payment_pending_task_model.dart';
import 'package:flutter/material.dart';

class PaymentAllTaskCard extends StatelessWidget {
  final PaymentPendingTaskModel task;

  const PaymentAllTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(IconPath.location),
                const SizedBox(width: 4),
                Text(
                  task.location,
                  style: commonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              task.description,
              style: commonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 8),

            // Confirmed Price
            Row(
              children: [
                // Price Container
                Container(
                  height: 34,
                  width: 90,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "\$${task.totalAmount.toStringAsFixed(0)}",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Date, Time, and Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task.date}   ${task.time} uur",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 140,
                  height: 44,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        return AppColors.primaryBlueWithShadow;
                      }),
                      side: WidgetStateProperty.resolveWith<BorderSide>((
                        states,
                      ) {
                        return BorderSide(
                          color: AppColors.primaryBlueWithShadow,
                        );
                      }),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),

                    onPressed: () {
                      // Get.snackbar(
                      //   "Payment Pending",
                      //   "Invoice: ${task.invoiceNumber}",
                      // );
                    },
                    child: Center(
                      child: Text(
                        "Bekijk Factuur",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryWhite,
                        ),
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
