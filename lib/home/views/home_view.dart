// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:people_manager/gen/assets.gen.dart';
import 'package:people_manager/home/bloc/home_bloc.dart';
import 'package:people_manager/home/views/create_and_edit_view.dart';
import 'package:people_manager/home/widgets/custom_paints.dart';
import 'package:people_manager/home/widgets/tab_button.dart';
import 'package:people_manager/home/widgets/user_card.dart';
import 'package:people_manager/utils/app_colors.dart';
import 'package:people_manager/utils/app_sizes.dart';
import 'package:people_manager/utils/app_strings.dart';
import 'package:people_manager/utils/get_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeGetUserListEvent());
  }

  bool isActivatedTabOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const CreateAndEditView();
              },
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.r),
        ),
        child: SvgPicture.asset(Assets.svgs.addIcon),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: 180.h,
                  color: AppColors.primaryColor,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svgs.logo),
                    SizedBox(height: 8.h),
                    Text(
                      'Service Provider List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              CustomPaint(
                painter: CustomShapeBorder(),
                child: Container(
                  height: 180.h,
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding.w,
                ),
                child: Column(
                  children: <Widget>[
                    // SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(
                          child: TabButton(
                            isActive: isActivatedTabOpen,
                            onTap: () {
                              setState(() {
                                isActivatedTabOpen = true;
                              });
                            },
                            text: AppStrings.active,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: TabButton(
                            isActive: !isActivatedTabOpen,
                            onTap: () {
                              setState(() {
                                isActivatedTabOpen = false;
                              });
                            },
                            text: AppStrings.deactivate,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 16.h),
                    BlocConsumer<HomeBloc, HomeState>(
                      bloc: context.read<HomeBloc>(),
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is HomeInitialState || state is HomeLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.primaryColor,
                            ),
                          );
                        }

                        if (state is HomeErrorState) {
                          return Center(
                            child: Text(
                              state.error,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }

                        if (state is HomeLoadedState) {
                          if (isActivatedTabOpen && context.read<HomeBloc>().activeUsers.isEmpty) {
                            return Center(
                              child: Text(
                                AppStrings.noActivePeopleFound,
                                style: TextStyle(
                                  color: AppColors.lightText,
                                  fontSize: 16.sp,
                                ),
                              ),
                            );
                          }

                          if (!isActivatedTabOpen && context.read<HomeBloc>().inactiveUsers.isEmpty) {
                            return Center(
                              child: Text(
                                AppStrings.noInactivePeopleFound,
                                style: TextStyle(
                                  color: AppColors.lightText,
                                  fontSize: 16.sp,
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: isActivatedTabOpen ? context.read<HomeBloc>().activeUsers.length : context.read<HomeBloc>().inactiveUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                final user = isActivatedTabOpen ? context.read<HomeBloc>().activeUsers[index] : context.read<HomeBloc>().inactiveUsers[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: UserCard(
                                    name: user.name ?? '',
                                    email: user.email ?? '',
                                    gender: user.gender ?? '',
                                    profilePlaceholderColor: getColor(index),
                                    isDeactivated: user.status == ActiveStatus.inactive.name,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                            return CreateAndEditView(
                                              user: user,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
