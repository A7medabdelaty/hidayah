import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class QiblaDirectionText extends StatelessWidget {
  final double direction;

  const QiblaDirectionText({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${'Qibla Direction'.tr()}: ${direction.toStringAsFixed(1)}°',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
