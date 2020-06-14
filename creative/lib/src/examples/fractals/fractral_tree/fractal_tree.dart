import 'dart:math' show pi, sin, cos;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Branch {
  const Branch(this.parent, this.end);

  final Branch parent;
  final Offset end;

  Offset get origin => parent?.end ?? Offset.zero;
  double get length => (end - origin).distance;
  double get lengthSquared => (end - origin).distanceSquared;

  Branch createChild(double scale, double phi) {
    final vector = end - origin;
    final c = cos(phi);
    final s = sin(phi);
    final dx = end.dx + scale * (c * vector.dx - s * vector.dy);
    final dy = end.dy + scale * (s * vector.dx + c * vector.dy);
    return Branch(this, Offset(dx, dy));
  }
}

class FractalTree extends StatefulWidget {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const defaultSize = Size(320, 400);

  const FractalTree({
    Key key,
    Color lineColor: white,
    Color backgroundColor: black,
    Size size: defaultSize,
  })  : lineColor = lineColor ?? white,
        backgroundColor = backgroundColor ?? black,
        size = size ?? defaultSize,
        super(key: key);

  final Color lineColor;
  final Color backgroundColor;
  final Size size;

  @override
  _FractalTreeState createState() => _FractalTreeState();
}

class _FractalTreeState extends State<FractalTree> {
  static const maxScale = 0.72;
  static const maxPhi = pi / 6;
  double scale = 0.67;
  double phi = pi / 6;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        color: widget.backgroundColor,
        height: widget.size.height,
        width: widget.size.width,
        child: CustomPaint(
          painter: TreePainter(scale, phi),
        ),
      ),
      Slider(
        value: phi,
        onChanged: (value) => setState(() => phi = value),
        min: 0,
        max: maxPhi,
      ),
      Slider(
        value: scale,
        onChanged: (value) => setState(() => scale = value),
        min: 0,
        max: maxScale,
      ),
      Slider(
        value: scale,
        onChanged: (value) => setState(() {
          scale = value;
          phi = maxPhi * (value / maxScale);
        }),
        min: 0,
        max: maxScale,
      ),
    ]);
  }
}

class TreePainter extends CustomPainter {
  const TreePainter(this.scale, this.phi)
      : assert(scale != null),
        assert(phi != null);

  final double scale;
  final double phi;

  @override
  void paint(Canvas canvas, Size size) {
    final _branchPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = FractalTree.white;
    final _leafPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.pink;

    final xref = size.width / 2;
    final yref = size.height;
    Offset transform(Offset offset) {
      return Offset(xref + offset.dx, yref - offset.dy);
    }

    void drawBranch(Branch branch) {
      final paint = branch.lengthSquared > 80 ? _branchPaint : _leafPaint;
      canvas.drawLine(transform(branch.origin), transform(branch.end), paint);
    }

    void drawTree(Branch b) {
      drawBranch(b);
      if (b.lengthSquared > 16) {
        final bRight = b.createChild(scale, -phi);
        drawTree(bRight);
        final bLeft = b.createChild(scale, phi);
        drawTree(bLeft);
      }
    }

    final b = Branch(null, Offset(0, 80));
    drawTree(b);
  }

  @override
  bool shouldRepaint(TreePainter old) => old.phi != phi;
}
