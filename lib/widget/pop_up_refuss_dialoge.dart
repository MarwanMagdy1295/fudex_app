import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/core/utils/constants.dart';
import 'package:kaf_app/widget/custom_button.dart';
import 'package:kaf_app/widget/custom_text_form_field.dart';

Future<void> popUpRefussDialog(
  context, {
  String? messege,
  required bool isSupervisor,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0.r))),
        content: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Assets.icons.refussIcon.svg(),
                  Constatnts.width8,
                  Text(
                    'add_new_request_screen.rejection_reason.tr()',
                    textAlign: TextAlign.center,
                    style: AppTheme.textTheme.displayMedium!.copyWith(
                      color: AppColors.primary,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ],
              ),
              Constatnts.height10,
              customTextFeild(
                isTitleAviable: false,
                lines: 3,
                controller: !isSupervisor
                    ? TextEditingController(text: messege)
                    : TextEditingController(),
                hint: 'add_new_request_screen.request_body_hint.tr()',
                hintStyle: AppTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.grey500,
                  fontWeight: FontWeight.w400,
                ),
                contentStyle: AppTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.grey500,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                editable: !isSupervisor ? false : true,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 14.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: AppColors.grey300,
                  ),
                ),
              ),
              !isSupervisor ? Container() : Constatnts.height10,
              !isSupervisor
                  ? Container()
                  : customButton(
                      onTap: () {},
                      title: 'supervisor_requests.send.tr()',
                      titleStyle: AppTheme.textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.all(10.0),
                    ),
            ],
          ),
        ),
      );
    },
  );
}
