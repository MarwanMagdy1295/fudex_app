import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/assets/assets.gen.dart';
import 'package:kaf_app/src/core/utils/constants.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';

class SelectedColorContainer extends StatelessWidget {
  final AddProductCubit cubit;
  final Color? color;
  const SelectedColorContainer({
    super.key,
    required this.cubit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 6.0.w),
      decoration: BoxDecoration(
        color: const Color(0xff28A6FD).withOpacity(.16),
        borderRadius: BorderRadius.circular(12.0.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 31.0.w,
            height: 26.0.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.0.w),
            ),
          ),
          Constatnts.width8,
          GestureDetector(
            onTap: () {},
            child: ClipOval(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.0.h),
                color: const Color(0xffF3F3F3),
                child: Assets.icons.bin.svg(
                  width: 8.0.w,
                  height: 8.0.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
