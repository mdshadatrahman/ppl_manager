import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:people_manager/utils/app_colors.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    required this.text,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.2.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : null,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isActive ? AppColors.primaryColor : AppColors.inactive,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? AppColors.lightText : AppColors.darkText2,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
