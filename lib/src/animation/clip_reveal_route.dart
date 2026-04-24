import 'package:flutter/widgets.dart';

class ClipRevealClipper extends CustomClipper<Path> {
  ClipRevealClipper({
    required this.fraction,
    required this.center,
  });

  final double fraction;
  final Offset center;

  @override
  Path getClip(Size size) {
    final maxRadius = _distanceToFurthestCorner(size, center);
    return Path()
      ..addOval(Rect.fromCircle(
        center: center,
        radius: maxRadius * fraction,
      ));
  }

  double _distanceToFurthestCorner(Size size, Offset center) {
    final distanceToTopLeft = center.distance;
    final distanceToTopRight = (center - Offset(size.width, 0)).distance;
    final distanceToBottomLeft = (center - Offset(0, size.height)).distance;
    final distanceToBottomRight =
        (center - Offset(size.width, size.height)).distance;

    return [
      distanceToTopLeft,
      distanceToTopRight,
      distanceToBottomLeft,
      distanceToBottomRight,
    ].reduce((a, b) => a > b ? a : b);
  }

  @override
  bool shouldReclip(ClipRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.center != center;
  }
}
