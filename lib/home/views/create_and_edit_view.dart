// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:people_manager/utils/app_colors.dart';
import 'package:people_manager/utils/app_sizes.dart';
import 'package:people_manager/utils/custom_dropdown_button.dart';
import 'package:people_manager/utils/custom_text_field.dart';

class CreateAndEditView extends StatefulWidget {
  const CreateAndEditView({
    this.contact,
    super.key,
  });

  final Contact? contact;

  @override
  State<CreateAndEditView> createState() => _CreateAndEditViewState();
}

class _CreateAndEditViewState extends State<CreateAndEditView> {
  String? _selectedGender;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Row(
          children: [
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
            SizedBox(width: 8.w),
            Text(
              widget.contact == null ? 'Create' : 'Update',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            CustomTextField(
              controller: TextEditingController(text: widget.contact?.name),
              labelText: 'Name',
              hintText: 'Enter your name',
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: TextEditingController(text: widget.contact?.name),
              labelText: 'Email',
              hintText: 'Enter your email address',
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Email is required';
                }
                if (!v.isValidEmail()) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            GenderDropdownButton(
              genders: const ['Male', 'Female', 'Other'],
              selectedValue: _selectedGender,
              onChanged: (v) {
                setState(() {
                  _selectedGender = v;
                });
              },
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                  Switch(
                    activeColor: AppColors.primaryColor,
                    thumbColor: MaterialStateProperty.all(AppColors.primaryColor),
                    overlayColor: MaterialStateProperty.all(AppColors.primaryColor),
                    inactiveTrackColor: AppColors.switchInactiveColor,
                    activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                    trackOutlineColor: MaterialStateProperty.all(Colors.white),
                    value: status,
                    onChanged: (v) {
                      setState(() {
                        status = v;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  widget.contact == null ? 'SAVE' : 'UPDATE',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
