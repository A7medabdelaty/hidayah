import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'qibla_direction_text.dart';
import 'qibla_compass_widget.dart';

class QiblaCompass extends StatelessWidget {
  final double qiblaDirection;

  const QiblaCompass({super.key, required this.qiblaDirection});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final direction = snapshot.data!.heading;
        if (direction == null) {
          return const Center(child: Text('Device does not have sensors'));
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QiblaDirectionText(direction: qiblaDirection),
            const SizedBox(height: 50),
            QiblaCompassWidget(
              direction: direction,
              qiblaDirection: qiblaDirection,
            ),
          ],
        );
      },
    );
  }
}