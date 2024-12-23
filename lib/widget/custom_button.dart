import 'package:flutter/material.dart';

SizedBox customButton({
  title,
  titleStyle,
  backgroundColor,
  padding,
  shape,
  onTap,
  icon,
  hasIcon = false,
}) {
  return SizedBox(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: shape,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          hasIcon ? icon : const SizedBox(),
          Text(
            title,
            style: titleStyle,
          ),
        ],
      ),
    ),
  );
}
