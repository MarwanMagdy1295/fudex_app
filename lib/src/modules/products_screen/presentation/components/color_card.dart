import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/color_model.dart';

class ColorCard extends StatelessWidget {
  final ColorModel color;
  const ColorCard({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 4.0.w),
        width: 16.w,
        height: 14.h,
        decoration: BoxDecoration(
          color: color.name == 'red'
              ? Colors.red
              : color.name == 'black'
                  ? Colors.black
                  : color.name == 'orange'
                      ? Colors.orange
                      : color.name == 'blue'
                          ? Colors.blue
                          : Colors.brown,
          // border: Border.all(
          //   color: AppColors.lightGreyText,
          // ),
          borderRadius: BorderRadius.circular(4.0.r),
        ),
      ),
    );
  }
}
