import 'package:flutter/material.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/constants.dart';

Column customTextFeild({
  controller,
  title,
  hint,
  icon,
  suffixIconColor,
  lines = 1,
  isTitleAviable = true,
  keyboardType,
  textInputAction,
  maxLength,
  inputFormatters,
  color,
  String? Function(String?)? validator,
  obscureText = false,
  border,
  padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
  hintStyle,
  isFill = false,
  titleStyle,
  contentStyle,
  editable = true,
  suffixIcon,
  prefixIcon,
  direction,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isTitleAviable
          ? Text(
              title,
              style: titleStyle,
            )
          : const SizedBox(),
      isTitleAviable ? Constatnts.height6 : const SizedBox(),
      TextFormField(
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        maxLength: maxLength,
        controller: controller,
        cursorColor: AppColors.primary,
        validator: validator,
        maxLines: lines,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: contentStyle,
        textDirection: direction,
        decoration: InputDecoration(
          enabled: editable,
          enabledBorder: border,
          disabledBorder: border,
          border: border,
          focusedBorder: border,
          contentPadding: padding,
          filled: isFill,
          fillColor: color,
          isDense: true,
          hintText: hint,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    ],
  );
}
