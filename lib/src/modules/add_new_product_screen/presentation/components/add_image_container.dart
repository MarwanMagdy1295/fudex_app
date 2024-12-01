import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';

class AddImageContainer extends StatelessWidget {
  final AddProductCubit cubit;
  const AddImageContainer({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2.w,
      height: MediaQuery.sizeOf(context).height * 0.08.h,
      child: GestureDetector(
        onTap: () {
          cubit.pickImageFromGallery(false);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [6],
          strokeWidth: 2.h,
          color: const Color(0xffE1E1E1),
          radius: Radius.circular(9.0.r),
          padding: EdgeInsets.all(6.0.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff28A6FD),
                    ),
                  ),
                  child: Icon(
                    size: 16.0.h,
                    Icons.add,
                    color: const Color(0xff28A6FD),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
