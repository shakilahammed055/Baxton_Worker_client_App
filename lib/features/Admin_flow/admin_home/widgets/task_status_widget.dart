import 'package:flutter/material.dart';

class TaskStatusRow extends StatelessWidget {
  final Color color;
  final String label;
  final String data;

  TaskStatusRow({required this.color, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 6.4, color: color),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xff8C97A7),
          ),
        ),
        SizedBox(width: 5),
        Text(
          data,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xff2A2E33),
          ),
        ),
      ],
    );
  }
}