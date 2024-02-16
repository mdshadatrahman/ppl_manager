// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:people_manager/gen/assets.gen.dart';
import 'package:people_manager/utils/app_colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    required this.name,
    required this.email,
    required this.gender,
    required this.onTap,
    required this.profilePlaceholderColor,
    this.isDeactivated = false,
    super.key,
  });

  final String name;
  final String gender;
  final String email;
  final VoidCallback onTap;
  final Color profilePlaceholderColor;
  final bool isDeactivated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 21.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.inactive.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(3, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55.h,
                width: 55.h,
                decoration: BoxDecoration(
                  color: isDeactivated ? AppColors.inactive : profilePlaceholderColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: AppColors.lightText,
                      fontSize: 31.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 13.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDeactivated ? AppColors.inactive : AppColors.darkText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    gender,
                    style: TextStyle(
                      color: AppColors.inactive,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: AppColors.inactive,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(Assets.svgs.editIcon),
            ),
          ),
        ],
      ),
    );
  }
}
