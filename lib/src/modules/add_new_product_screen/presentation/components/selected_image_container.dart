import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/assets/assets.gen.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';

class SelectedImageContainer extends StatelessWidget {
  const SelectedImageContainer({
    super.key,
    required this.addProductCubit,
    required this.image,
  });

  final AddProductCubit addProductCubit;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0.h),
      width: MediaQuery.sizeOf(context).width * 0.28.w,
      height: MediaQuery.sizeOf(context).height * 0.12.h,
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [6],
        strokeWidth: 2.h,
        color: const Color(0xffE1E1E1),
        radius: Radius.circular(9.0.r),
        padding: EdgeInsets.all(4.0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    addProductCubit.deleteImage(mainImg: false, img: image);
                  },
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0.w, vertical: 4.0.h),
                      color: const Color(0xffF3F3F3),
                      child: Assets.icons.bin.svg(
                        width: 14.w,
                        height: 14.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 2.0.h),
              width: MediaQuery.sizeOf(context).width * 0.2.w,
              height: MediaQuery.sizeOf(context).height * 0.06.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    image,
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
