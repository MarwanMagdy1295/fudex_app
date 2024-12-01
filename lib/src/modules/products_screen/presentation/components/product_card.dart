import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/core/utils/assets/assets.gen.dart';
import 'package:kaf_app/src/core/utils/assets/translations/keys.dart';
import 'package:kaf_app/src/core/utils/constants.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/product_model.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/components/color_card.dart';
import 'dart:ui' as ui;

import 'package:kaf_app/src/modules/products_screen/presentation/components/size_card.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff717171).withOpacity(.1),
            blurRadius: 10.0,
            spreadRadius: -1.0,
            offset: const Offset(-2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(6.r),
              ),
              border: const Border(
                bottom: BorderSide(color: Color(0xffDBDBDB)),
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    products_screen.active_product.tr(),
                    style: AppTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Switch(
                            activeTrackColor: AppColors.primary,
                            inactiveTrackColor: AppColors.grey,
                            inactiveThumbColor: AppColors.white,
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Constatnts.width10,
                      Assets.icons.bin.svg(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 2.0.h),
                    width: MediaQuery.sizeOf(context).width * 0.2.w,
                    height: MediaQuery.sizeOf(context).height * 0.12.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0.r),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(
                          product.mainImage ?? File(''),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 12.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4.w,
                          child: Text(
                            product.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTheme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Constatnts.height6,
                        Text(
                          '${product.price ?? ''} ${products_screen.rs.tr()}',
                          style: AppTheme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1C5CF2),
                          ),
                        ),
                        Constatnts.height6,
                        product.sizes != null
                            ? Wrap(
                                children: [
                                  ...product.sizes!
                                      .map(
                                        (size) => SizedCard(size: size),
                                      )
                                      .toList(),
                                  Constatnts.width6,
                                ],
                              )
                            : Container(),
                        Constatnts.height10,
                        product.colors != null
                            ? Wrap(
                                children: [
                                  ...product.colors!
                                      .map(
                                        (color) => ColorCard(color: color),
                                      )
                                      .toList(),
                                  Constatnts.width6,
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
