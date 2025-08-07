import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskStatusRow extends StatelessWidget {
  final Color color;
  final String label;
  final String data;

  const TaskStatusRow({
    super.key,
    required this.color,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 6.4.sp, color: color),
        SizedBox(width: 8.w),
        Text(
          label,
          maxLines: 2,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xff8C97A7),
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          data,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xff2A2E33),
          ),
        ),
      ],
    );
  }
}
