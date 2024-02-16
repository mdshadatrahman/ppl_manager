import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:people_manager/utils/app_colors.dart';

class GenderDropdownButton extends StatelessWidget {
  const GenderDropdownButton({
    required this.genders,
    this.selectedValue,
    this.onChanged,
    super.key,
  });
  final List<String> genders;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: DropdownButton(
        isExpanded: true,
        hint: Text(
          'Gender',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textFieldTextColor,
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textFieldTextColor,
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        underline: const SizedBox(),
        value: selectedValue,
        items: genders.map((e) {
          return DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textFieldTextColor,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class Contact {
  Contact({
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  final String? name;
  final String? email;
  final String? gender;
  final bool? status;
}
