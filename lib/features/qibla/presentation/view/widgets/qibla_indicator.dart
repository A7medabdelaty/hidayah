import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QiblaIndicator extends StatelessWidget {
  const QiblaIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Column(
        children: [
          Container(
            width: 5,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.amber.shade700,
                width: 3,
              ),
            ),
          ),
          Icon(
            Icons.arrow_downward,
            color: Colors.amber.shade700,
            size: 30.sp,
          ),
        ],
      ),
    );
  }
}
