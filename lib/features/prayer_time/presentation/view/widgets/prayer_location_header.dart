import 'package:flutter/material.dart';

class PrayerLocationHeader extends StatelessWidget {
  const PrayerLocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.location_on, color: Colors.white),
        SizedBox(width: 6),
        Text(
          "Cairo, Egypt",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
