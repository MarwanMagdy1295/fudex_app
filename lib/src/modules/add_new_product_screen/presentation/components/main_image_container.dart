import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/core/utils/assets/assets.gen.dart';
import 'package:kaf_app/src/core/utils/assets/translations/keys.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';

class MainImageContainer extends StatelessWidget {
  const MainImageContainer({
    super.key,
    required this.addProductCubit,
  });

  final AddProductCubit addProductCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5.w,
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const [6],
            strokeWidth: 2.h,
            color: const Color(0xffE1E1E1),
            radius: Radius.circular(9.0.r),
            padding: EdgeInsets.all(10.0.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: addProductCubit.mainImage != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0.w, vertical: 4.0.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffD8E3FF),
                        borderRadius: BorderRadius.circular(6.0.r),
                      ),
                      child: Text(
                        add_new_product_screen.main_image.tr(),
                        style: AppTheme.textTheme.titleLarge?.copyWith(
                          color: const Color(0xff1C5CF2),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    addProductCubit.mainImage != null
                        ? GestureDetector(
                            onTap: () {
                              addProductCubit.deleteImage(mainImg: true);
                            },
                            child: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0.w, vertical: 4.0.h),
                                  color: const Color(0xffF3F3F3),
                                  child: Assets.icons.bin.svg()),
                            ),
                          )
                        : Container(),
                  ],
                ),
                addProductCubit.mainImage != null
                    ? Container(
                        margin: EdgeInsets.only(top: 4.0.h),
                        width: MediaQuery.sizeOf(context).width * .32.w,
                        height: 86.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0.r),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                              addProductCubit.mainImage!,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          addProductCubit.pickImageFromGallery(true);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: const Color(0xff28A6FD),
                            ),
                          ),
                          child: Icon(
                            size: 30.0.h,
                            Icons.add,
                            color: const Color(0xff28A6FD),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
