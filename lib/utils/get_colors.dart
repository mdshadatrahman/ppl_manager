import 'dart:ui';

import 'package:people_manager/utils/app_colors.dart';

/// This function returns a color based on the index.
/// It is used to give a different color to each user card.
Color getColor(int index) {
  const colors = [
    AppColors.blue,
    AppColors.red,
    AppColors.primaryColor,
    AppColors.yellow,
  ];
  return colors[index % colors.length];
}
