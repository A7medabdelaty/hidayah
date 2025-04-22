import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RotatingCompass extends StatelessWidget {
  final double direction;
  final double qiblaDirection;

  const RotatingCompass({
    super.key,
    required this.direction,
    required this.qiblaDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (direction * (math.pi / 180) * -1),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/compass.webp',
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 1.sw,
          ),
          Transform.rotate(
            angle: (qiblaDirection * (math.pi / 180)),
            child: Image.asset(
              'assets/images/needle.png',
              height: 0.8.sw,
            ),
          ),
        ],
      ),
    );
  }
}
