// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:people_manager/gen/assets.gen.dart';
import 'package:people_manager/home/widgets/contact_card.dart';
import 'package:people_manager/home/widgets/tab_button.dart';
import 'package:people_manager/utils/app_colors.dart';
import 'package:people_manager/utils/app_sizes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.r),
        ),
        child: SvgPicture.asset(Assets.svgs.addIcon),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding.w,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: TabButton(
                        isActive: true,
                        onTap: () {},
                        text: 'Active',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: TabButton(
                        isActive: false,
                        onTap: () {},
                        text: 'Deactivate',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: ContactCard(
                          name: 'Abida Shekh Rashida',
                          email: 'amin@gmail.com',
                          gender: 'Female',
                          profilePlaceholderColor: AppColors.blue,
                          isDeactivated: index.isEven,
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
