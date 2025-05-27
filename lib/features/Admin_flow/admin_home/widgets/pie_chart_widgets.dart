import 'package:baxton/features/Admin_flow/admin_home/widgets/task_overview_chart.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_status_widget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class piechartwidget extends StatelessWidget {
  const piechartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 362,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffFFFFFF),
        border: Border.all(width: 1, color: Color(0xffE1E7EC)),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Taak Overzicht",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff666666),
            ),
          ),
          SizedBox(height: 11),
          Align(alignment: Alignment.center, child: TaskOverviewChart()),
          SizedBox(height: 28),
          Row(
            children: [
              TaskStatusRow(
                color: Color(0xff62B2FD),
                label: "Toegewezen Taken",
                data: "15",
              ),
              SizedBox(width: 15),
              TaskStatusRow(
                color: Color(0xff9BDFC4),
                label: "In Behandeling",
                data: "25",
              ),
            ],
          ),
          SizedBox(height: 13),
          Row(
            children: [
              TaskStatusRow(
                color: Color(0xffF99BAB),
                label: "Voltooide Taak",
                data: "15",
              ),
              SizedBox(width: 15),
              TaskStatusRow(
                color: Color(0xff9F97F7),
                label: "Te Laat Taken",
                data: "10",
              ),
            ],
          ),
          SizedBox(height: 13),
          TaskStatusRow(
            color: Color(0xffFFB44F),
            label: "Niet-Toegewezen Taken",
            data: "5",
          ),
        ],
      ),
    );
  }
}
