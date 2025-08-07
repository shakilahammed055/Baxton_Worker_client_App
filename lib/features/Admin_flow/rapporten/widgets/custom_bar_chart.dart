import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';

class CustomBarChart extends StatelessWidget {
  CustomBarChart({super.key});

  final RapportenController controller = Get.find<RapportenController>();

  // Build each bar group dynamically
  BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
        ),
      ],
    );
  }

  // Legend item widget
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF8C97A7),
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Wait until data is fetched
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final stats = controller.taskStats;
      if (stats.isEmpty) {
        return const Center(child: Text('Geen gegevens beschikbaar.'));
      }

      // Build bars dynamically
      final List<BarChartGroupData> barGroups = [];
      for (int i = 0; i < stats.length; i++) {
        final color = controller.barColors[i % controller.barColors.length];
        barGroups.add(_buildBarGroup(i, stats[i].count.toDouble(), color));
      }

      // Dynamically calculate max Y axis
      final maxY = controller.maxCount.toDouble() + 5;

      return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 328, maxWidth: 770),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chart section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 102,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Y-axis labels
                      Container(
                        width: 29,
                        height: 102,
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (var value in [
                              maxY,
                              maxY * 0.75,
                              maxY * 0.5,
                              maxY * 0.25,
                              0,
                            ])
                              Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Color(0xFFB8C4CE),
                                  fontSize: 10,
                                  height: 1.5,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Bar chart
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barGroups: barGroups,
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              barTouchData: BarTouchData(enabled: false),
                              maxY: maxY,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Legends
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (int i = 0; i < stats.length; i++)
                      _buildLegendItem(
                        controller.barColors[i % controller.barColors.length],
                        stats[i].label,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
