// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/confirmed_task_model.dart';
// import 'package:flutter/material.dart';

// class ConfirmedTaskCard extends StatelessWidget {
//   final ConfirmedTaskModel employyesConfirmedTask;
//   const ConfirmedTaskCard({super.key, required this.employyesConfirmedTask});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.primaryWhite,

//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: AppColors.secondaryWhite),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Title
//                 Text(
//                   employyesConfirmedTask.title,
//                   style: getTextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primaryBlack,
//                   ),
//                 ),
//                 const Spacer(),

//                 // Location
//                 Image.asset(IconPath.location),
//                 SizedBox(width: 4),
//                 Text(
//                   employyesConfirmedTask.location,
//                   style: getTextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryBlack,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),

//             // Description
//             Text(
//               employyesConfirmedTask.description,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.secondaryBlack,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Confirmed Price
//             Row(
//               children: [
//                 Container(
//                   height: 29,
//                   width: 63,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.secondaryBlue,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       employyesConfirmedTask.price,
//                       style: getTextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.primaryBlue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),

//             // Date, Time and Start-Task Button
//             Row(
//               children: [
//                 Text(
//                   // date
//                   "${employyesConfirmedTask.dateTime.day}/${employyesConfirmedTask.dateTime.month}/${employyesConfirmedTask.dateTime.year}"
//                   // time
//                   "${employyesConfirmedTask.dateTime.hour.toString().padLeft(2, '0')}:${employyesConfirmedTask.dateTime.minute.toString().padLeft(2, '0')} AM",
//                   style: getTextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryBlack,
//                   ),
//                 ),
//                 Spacer(),

//                 // start-task button
//                 SizedBox(
//                   width: 140,
//                   height: 44,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryBlue,

//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(62),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                     ),
//                     child: const Text('Taak Starten'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/task_execution_screen.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/confirmed_task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmedTaskCard extends StatelessWidget {
  final ConfirmedTaskModel employyesConfirmedTask;
  final bool isStartEnabled;

  const ConfirmedTaskCard({
    super.key,
    required this.employyesConfirmedTask,
    required this.isStartEnabled,
  });

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
            // Title & Location Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    employyesConfirmedTask.title,
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
                  employyesConfirmedTask.location,
                  style: getTextStyle(
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
              employyesConfirmedTask.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 8),

            // Confirmed Price
            Row(
              children: [
                Container(
                  height: 29,
                  width: 63,
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
                      employyesConfirmedTask.price,
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
            const SizedBox(height: 4),

            // Date, Time, and Start Task Button
            Row(
              children: [
                Text(
                  "${employyesConfirmedTask.dateTime.day.toString().padLeft(2, '0')}/"
                  "${employyesConfirmedTask.dateTime.month.toString().padLeft(2, '0')}/"
                  "${employyesConfirmedTask.dateTime.year} "
                  "${employyesConfirmedTask.dateTime.hour.toString().padLeft(2, '0')}:"
                  "${employyesConfirmedTask.dateTime.minute.toString().padLeft(2, '0')} "
                  "uur",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
                const Spacer(),

                // Start Task Button
                // SizedBox(
                //   width: 160,
                //   height: 44,
                //   child: ElevatedButton(
                //     onPressed:
                //         employyesConfirmedTask.isPaymentCompleted
                //             ? () {}
                //             : null,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor:
                //           employyesConfirmedTask.isPaymentCompleted
                //               ? AppColors.primaryBlue
                //               : AppColors.primaryGold,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(62),
                //       ),
                //       padding: const EdgeInsets.symmetric(vertical: 10),
                //     ),
                //     child: Text(
                //       'Taak Starten',

                //       style: getTextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.primaryWhite,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 160,
                  height: 44,
                  child: ElevatedButton(
                    onPressed:
                        isStartEnabled
                            ? () {
                              Get.to(() => TaskExecutionScreen());
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isStartEnabled
                              ? AppColors.primaryBlue
                              : AppColors.primaryGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      'Taak Starten',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isStartEnabled
                                ? AppColors.primaryGreen
                                : AppColors.primaryBlue,
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
