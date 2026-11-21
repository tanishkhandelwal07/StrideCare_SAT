import 'package:flutter/widgets.dart';
import 'package:stridecare/design/tokens.dart';

/// Visual companion to the empty walking summary. It conveys no extra reading.
class CaneIllustration extends StatelessWidget {
  const CaneIllustration({super.key});

  @override
  Widget build(BuildContext context) => const ExcludeSemantics(
    child: SizedBox.square(
      dimension: CareTokens.illustrationSize,
      child: CustomPaint(painter: _CanePainter()),
    ),
  );
}

class _CanePainter extends CustomPainter {
  const _CanePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Path coordinates are expressed in the illustration's 96-unit viewBox.
    canvas.save();
    canvas.scale(size.width / 96, size.height / 96);
    final pen = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = CareTokens.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = CareTokens.teal;
    final cane = Path()
      ..moveTo(34, 23)
      ..cubicTo(35, 13, 43, 10, 51, 14)
      ..cubicTo(56, 17, 58, 21, 56, 30)
      ..lineTo(45, 75)
      ..lineTo(40, 74)
      ..lineTo(51, 29)
      ..cubicTo(53, 22, 49, 18, 45, 19)
      ..cubicTo(41, 19, 40, 23, 39, 25)
      ..quadraticBezierTo(35, 28, 34, 23)
      ..close();
    canvas.drawPath(cane, pen);
    final tip = Path()
      ..moveTo(38, 74)
      ..lineTo(47, 76)
      ..lineTo(46, 82)
      ..quadraticBezierTo(41, 83, 36, 80)
      ..close();
    canvas.drawPath(tip, pen);
    canvas.save();
    canvas.translate(52, 39);
    canvas.rotate(0.23);
    final clip = RRect.fromRectAndRadius(
      const Rect.fromLTWH(-6, -7, 12, 14),
      const Radius.circular(3),
    );
    canvas.drawRRect(clip, Paint()..color = CareTokens.paper);
    canvas.drawRRect(clip, pen);
    canvas.drawLine(const Offset(-2, -2), const Offset(2, -2), pen);
    canvas.restore();
    canvas.drawLine(
      const Offset(27, 84),
      const Offset(58, 84),
      pen..color = CareTokens.rule,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CanePainter oldDelegate) => false;
}
