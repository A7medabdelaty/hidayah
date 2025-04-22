import 'package:flutter/material.dart';
import 'rotating_compass.dart';
import 'qibla_indicator.dart';

class QiblaCompassWidget extends StatelessWidget {
  final double direction;
  final double qiblaDirection;

  const QiblaCompassWidget({
    super.key,
    required this.direction,
    required this.qiblaDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotatingCompass(
          direction: direction,
          qiblaDirection: qiblaDirection,
        ),
        const QiblaIndicator(),
      ],
    );
  }
}