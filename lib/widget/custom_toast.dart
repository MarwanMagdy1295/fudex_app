import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';

void customToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColors.primary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// void customToastWaiting(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.TOP,
//     backgroundColor: kOrangeColor,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }
