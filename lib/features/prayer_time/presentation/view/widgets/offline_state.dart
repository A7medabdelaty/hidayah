import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OfflineState extends StatelessWidget {
  const OfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.wifiOff,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'You are offline',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No cached prayer times available',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
