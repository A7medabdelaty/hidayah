import 'package:flutter/material.dart';
import 'package:hidayah/core/constants/app_colors.dart';

class PrayerTimeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final bool isNext;
  final int index;

  const PrayerTimeRow({
    super.key,
    required this.icon,
    required this.label,
    required this.time,
    this.isNext = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: index % 2 == 0
          ? AppColors.foregroundColor
          : AppColors.superLightGreenColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(time, style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
