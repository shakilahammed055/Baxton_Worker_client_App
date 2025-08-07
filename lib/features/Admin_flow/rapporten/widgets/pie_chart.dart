// ignore_for_file: prefer_is_empty

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_status_widget.dart';
import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/taakvoltooing_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class piechart extends StatelessWidget {
  piechart({super.key});

  final controller = Get.find<RapportenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 448,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: const Color(0xffE1E7EC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Omzet per Taaktype",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textThird,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 42),
                Align(alignment: Alignment.center, child: SalesAnalysisChart()),
                const SizedBox(height: 28),

                // ✅ WRAP your dynamic rows in Obx
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TaskStatusRow(
                            color: const Color(0xff62B2FD),
                            label:
                                controller.taskStats.length > 0
                                    ? controller.taskStats[0].label
                                    : '—',
                            data:
                                controller.taskStats.length > 0
                                    ? '${controller.taskStats[0].amount}'
                                    : '0',
                          ),
                          SizedBox(width: 15.w),
                        ],
                      ),
                      SizedBox(height: 13.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TaskStatusRow(
                            color: const Color(0xffF99BAB),
                            label:
                                controller.taskStats.length > 2
                                    ? controller.taskStats[2].label
                                    : '—',
                            data:
                                controller.taskStats.length > 2
                                    ? '${controller.taskStats[2].amount}'
                                    : '0',
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      TaskStatusRow(
                        color: const Color(0xff9F97F7),
                        label:
                            controller.taskStats.length > 3
                                ? controller.taskStats[3].label
                                : '—',
                        data:
                            controller.taskStats.length > 3
                                ? '${controller.taskStats[3].amount}'
                                : '0',
                      ),
                      SizedBox(height: 13.h),
                      TaskStatusRow(
                        color: const Color(0xff9BDFC4),
                        label:
                            controller.taskStats.length > 1
                                ? controller.taskStats[1].label
                                : '—',
                        data:
                            controller.taskStats.length > 1
                                ? '${controller.taskStats[1].amount}'
                                : '0',
                      ),
                      SizedBox(height: 13.h),
                      TaskStatusRow(
                        color: const Color(0xffFFB44F),
                        label:
                            controller.taskStats.length > 4
                                ? controller.taskStats[4].label
                                : '—',
                        data:
                            controller.taskStats.length > 4
                                ? '${controller.taskStats[4].amount}'
                                : '0',
                      ),
                      const SizedBox(height: 13),
                      TaskStatusRow(
                        color: const Color(0xff62B2FD),
                        label:
                            controller.taskStats.length > 5
                                ? controller.taskStats[5].label
                                : '—',
                        data:
                            controller.taskStats.length > 5
                                ? '${controller.taskStats[5].amount}'
                                : '0',
                      ),
                      const SizedBox(height: 13),
                      TaskStatusRow(
                        color: const Color(0xff9BDFC4),
                        label:
                            controller.taskStats.length > 6
                                ? controller.taskStats[6].label
                                : '—',
                        data:
                            controller.taskStats.length > 6
                                ? '${controller.taskStats[6].amount}'
                                : '0',
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
