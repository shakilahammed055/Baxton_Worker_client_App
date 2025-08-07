import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final double maxYValue;

  LineChartPainter({List<double>? dataPoints, double? maxYValue})
    : dataPoints = dataPoints ?? [15.0, 40.0, 20.0, 30.0, 25.0],
      maxYValue = maxYValue ?? 40.0;

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 5.0;
    final leftPadding = 30.0;
    final availableWidth = size.width - padding * 2 - leftPadding;
    final labelHeight = 16.0;
    final chartHeight = size.height - labelHeight;

    final paint =
        Paint()
          ..color = const Color(0xff1E90FF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;

    final areaPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff0054FD),
              const Color(0xffDADEFF).withAlpha(40),
            ],
          ).createShader(
            Rect.fromLTRB(leftPadding, 0, size.width - padding, chartHeight),
          );

    final points = List<Offset>.generate(dataPoints.length, (i) {
      final x = leftPadding + availableWidth * (i / (dataPoints.length - 1));
      final y = chartHeight - (chartHeight * (dataPoints[i] / maxYValue));
      return Offset(x, y);
    });

    final path = Path();
    final areaPath = Path();

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      areaPath.moveTo(points.first.dx, chartHeight);
      areaPath.lineTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        final p0 = points[i - 1];
        final p1 = points[i];

        final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

        path.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );

        areaPath.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );
      }

      areaPath.lineTo(points.last.dx, chartHeight);
      areaPath.close();
    }

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(path, paint);

    final gridPaint =
        Paint()
          ..color = Colors.grey.withValues(alpha: 0.2)
          ..strokeWidth = 0.5;

    for (double y = 0.0; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      canvas.drawLine(
        Offset(leftPadding, yPos),
        Offset(size.width - padding, yPos),
        gridPaint,
      );
    }

    final textStyle = TextStyle(color: Colors.black54, fontSize: 10);

    // Y-axis labels
    for (double y = 0.0; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      final labelValue = (maxYValue * y).toInt();
      final textSpan = TextSpan(
        text: labelValue == 0 ? '0' : '${labelValue}k',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, yPos - textPainter.height / 2));
    }

    // X-axis labels based on data points count
    final weekLabels = List.generate(
      dataPoints.length,
      (index) => 'Week-${index + 1}',
    );
    for (int i = 0; i < weekLabels.length; i++) {
      final x = leftPadding + availableWidth * (i / (weekLabels.length - 1));
      final textSpan = TextSpan(text: weekLabels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - textPainter.height),
      );
    }

    // Highlight peak point
    int peakIndex = 0;
    double peakValue = 0;
    for (int i = 0; i < dataPoints.length; i++) {
      if (dataPoints[i] > peakValue) {
        peakValue = dataPoints[i];
        peakIndex = i;
      }
    }

    final peakPoint = points[peakIndex];
    final peakLabel = TextSpan(
      text: '${peakValue.toInt()}k',
      style: TextStyle(
        color: Colors.amber[700],
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
    final peakLabelPainter = TextPainter(
      text: peakLabel,
      textDirection: TextDirection.ltr,
    );
    peakLabelPainter.layout();

    final circlePaint = Paint()..color = Colors.white;
    final circleBorderPaint =
        Paint()
          ..color = const Color(0xff1E90FF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawCircle(peakPoint, 5, circlePaint);
    canvas.drawCircle(peakPoint, 5, circleBorderPaint);

    peakLabelPainter.paint(
      canvas,
      Offset(
        peakPoint.dx - peakLabelPainter.width / 2,
        peakPoint.dy - peakLabelPainter.height - 10,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
