// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:people_manager/home/bloc/home_bloc.dart';
import 'package:people_manager/home/widgets/user_card.dart';
import 'package:people_manager/models/user.dart';
import 'package:people_manager/shared/widgets/custom_dropdown_button.dart';
import 'package:people_manager/shared/widgets/custom_text_field.dart';
import 'package:people_manager/utils/app_colors.dart';
import 'package:people_manager/utils/app_sizes.dart';
import 'package:people_manager/utils/app_strings.dart';

class CreateAndEditView extends StatefulWidget {
  const CreateAndEditView({
    this.user,
    super.key,
  });

  final User? user;

  @override
  State<CreateAndEditView> createState() => _CreateAndEditViewState();
}

class _CreateAndEditViewState extends State<CreateAndEditView> with SingleTickerProviderStateMixin {
  bool _status = false;
  String? _selectedGender;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    try {
      _nameController.text = widget.user?.name ?? '';
      _emailController.text = widget.user?.email ?? '';
      _selectedGender = widget.user?.gender?.toTitleCase();
      widget.user?.status == ActiveStatus.active.name ? _status = true : _status = false;
      _initAnimation();
      if (_status) {
        switchOn();
      }
    } catch (e) {
      developer.log('Error: $e');
    }
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void switchOn() {
    _controller.forward();
  }

  void switchOff() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _status = false;
    _selectedGender = null;
    _controller.dispose();
    super.dispose();
  }

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
              widget.user == null ? AppStrings.create : AppStrings.update,
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
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: context.read<HomeBloc>(),
          listener: (context, state) {
            if (state is HomeUserCreatedState || state is HomeUserUpdatedState) {
              var message = '';
              if (state is HomeUserCreatedState) {
                message = state.message;
              } else if (state is HomeUserUpdatedState) {
                message = state.message;
              }
              Fluttertoast.showToast(msg: message);
              Navigator.of(context).pop();
            }
            if (state is HomeErrorState) {
              Fluttertoast.showToast(msg: state.error);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  CustomTextField(
                    controller: _nameController,
                    labelText: AppStrings.name,
                    hintText: AppStrings.enterYourName,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return AppStrings.nameIsRequired;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: _emailController,
                    labelText: AppStrings.email,
                    hintText: AppStrings.enterYourEmail,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return AppStrings.emailIsRequired;
                      }
                      if (!v.isValidEmail()) {
                        return AppStrings.invalidEmail;
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
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
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
                          AppStrings.status,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textFieldTextColor,
                          ),
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_status) {
                                  switchOff();
                                } else {
                                  switchOn();
                                }
                                setState(() {
                                  _status = !_status;
                                });
                              },
                              child: Container(
                                height: 22.h,
                                width: 64.w,
                                decoration: BoxDecoration(
                                  color: AppColors.switchInactiveColor,
                                  borderRadius: BorderRadius.circular(1000.r),
                                ),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(_animation.value * 42.w, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_status) {
                                        switchOff();
                                      } else {
                                        switchOn();
                                      }
                                      setState(() {
                                        _status = !_status;
                                      });
                                    },
                                    child: Container(
                                      height: 22.h,
                                      width: 22.w,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // Switch(
                        //   activeColor: AppColors.primaryColor,
                        //   thumbColor: MaterialStateProperty.all(AppColors.primaryColor),
                        //   overlayColor: MaterialStateProperty.all(AppColors.primaryColor),
                        //   inactiveTrackColor: AppColors.switchInactiveColor,
                        //   activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                        //   trackOutlineColor: MaterialStateProperty.all(Colors.white),
                        //   value: _status,
                        //   onChanged: (v) {
                        //     setState(() {
                        //       _status = v;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  if (state is HomeCreatingUserState || state is HomeUserUpdatingState)
                    const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.primaryColor,
                      ),
                    )
                  else
                    PrimaryButton(
                      buttonText: widget.user == null ? AppStrings.save : AppStrings.update.toUpperCase(),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (_selectedGender == null) {
                            Fluttertoast.showToast(msg: AppStrings.pleaseSelectGender);
                            return;
                          }

                          final user = User(
                            id: widget.user?.id,
                            name: _nameController.text,
                            email: _emailController.text,
                            gender: _selectedGender?.toLowerCase(),
                            status: _status ? ActiveStatus.active.name : ActiveStatus.inactive.name,
                          );
                          if (widget.user == null) {
                            context.read<HomeBloc>().add(HomeCreateUserEvent(user: user));
                          } else {
                            context.read<HomeBloc>().add(HomeUpdateUserEvent(user: user));
                          }
                        } else {
                          Fluttertoast.showToast(msg: AppStrings.pleaseFillAllTheFields);
                        }
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.buttonText,
    required this.onTap,
    super.key,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
