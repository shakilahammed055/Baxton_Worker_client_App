import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';

class SalesAnalysisChart extends StatelessWidget {
  SalesAnalysisChart({super.key});

  final controller = Get.find<RapportenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get dynamic counts from controller
      final stats = controller.taskStats;
      if (stats.isEmpty) {
        // if no data yet, show placeholder
        return const Center(child: CircularProgressIndicator());
      }

      // Extract counts (only non-zero)
      final counts = stats.map((e) => e.count).where((c) => c > 0).toList();

      // Extract colors (up to available)
      final colors = controller.barColors;

      return SizedBox(
        width: 180,
        height: 180,
        child: CustomPaint(painter: PieChartPainter(counts, colors)),
      );
    });
  }
}

class PieChartPainter extends CustomPainter {
  final List<int> counts;
  final List<Color> colors;

  PieChartPainter(this.counts, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    if (counts.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final total = counts.fold(0, (a, b) => a + b);
    double startAngle = -3.14159265359 / 2;

    for (int i = 0; i < counts.length; i++) {
      final sweepAngle = (counts[i] / total) * 2 * 3.14159265359;
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    // repaint when data changes
    return oldDelegate.counts != counts;
  }
}
