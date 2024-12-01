import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/size_model.dart';

class SizedCard extends StatelessWidget {
  final SizeModel size;
  const SizedCard({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 4.0.w),
        padding: EdgeInsets.all(5.0.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGreyText,
          ),
          borderRadius: BorderRadius.circular(4.0.r),
        ),
        child: Text(
          size.name ?? '',
          style: AppTheme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
