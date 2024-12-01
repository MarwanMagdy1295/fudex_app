import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/app/di_service.dart';
import 'package:kaf_app/src/core/hooks.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/core/utils/constants.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/add_image_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/main_image_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/selected_color_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/selected_image_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/selected_size_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/components/selected_words_container.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';
import 'package:kaf_app/src/core/utils/assets/translations/keys.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kaf_app/widget/custom_button.dart';
import 'package:kaf_app/widget/custom_text_form_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kaf_app/widget/loading_widget.dart';
// import 'dart:ui' as ui;

class AddProductScreen extends HookWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductCubit>(
      lazy: true,
      create: (context) => di(),
      child: HookBuilder(
        builder: (context) {
          final addProductCubit = context.watch<AddProductCubit>();
          useWillMount(() {
            // controller.refresh();
          });
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  surfaceTintColor: AppColors.white,
                  shadowColor: AppColors.black.withOpacity(.5),
                  elevation: 1,
                  systemOverlayStyle: const SystemUiOverlayStyle(),
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.black)),
                  title: Text(
                    add_new_product_screen.add_product.tr(),
                    style: AppTheme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  centerTitle: true,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 24.0.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurStyle: BlurStyle.solid,
                        blurRadius: 7,
                        color: Colors.black.withOpacity(0.2),
                      )
                    ],
                  ),
                  child: customButton(
                    onTap: () {
                      addProductCubit.addProduct(context);
                    },
                    title: add_new_product_screen.save.tr(),
                    titleStyle: AppTheme.textTheme.displaySmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(14.0),
                  ),
                ),
                body: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 22.0.w,
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 120.0.h),
                        child: Form(
                          key: addProductCubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Constatnts.height30,
                              Text(
                                add_new_product_screen.product_images.tr(),
                                style:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Constatnts.height10,
                              Constatnts.height2,
                              DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: const [6],
                                strokeWidth: 2.h,
                                color: const Color(0xffE1E1E1),
                                radius: Radius.circular(9.0.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      MainImageContainer(
                                          addProductCubit: addProductCubit),
                                      Constatnts.height14,
                                      addProductCubit.pickedImagesFromGallery ==
                                              null
                                          ? Container()
                                          : Wrap(
                                              spacing: 10.0.w,
                                              runSpacing: 10.0.h,
                                              children: [
                                                ...addProductCubit
                                                    .pickedImagesFromGallery!
                                                    .map(
                                                      (image) =>
                                                          SelectedImageContainer(
                                                              addProductCubit:
                                                                  addProductCubit,
                                                              image: image),
                                                    )
                                                    .toList(),
                                                AddImageContainer(
                                                  cubit: addProductCubit,
                                                ),
                                              ],
                                            ),
                                      Constatnts.height16,
                                      Text(
                                        add_new_product_screen.image_size.tr(),
                                        textAlign: TextAlign.center,
                                        style: AppTheme.textTheme.headlineSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              Text(
                                add_new_product_screen.product_name.tr(),
                                style:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Constatnts.height8,
                              customTextFeild(
                                controller: addProductCubit.nameController,
                                isTitleAviable: false,
                                hint: add_new_product_screen.product_name.tr(),
                                hintStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.lightGreyText,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.grey700,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  borderSide: BorderSide(
                                    color: AppColors.grey500.withOpacity(.17),
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: add_new_product_screen.department
                                          .tr(),
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff121725),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '* ',
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Constatnts.height8,
                              DropdownSearch<String>(
                                selectedItem: addProductCubit.category,
                                clearButtonProps:
                                    const ClearButtonProps(isVisible: false),
                                items: const [
                                  'bags',
                                  'T-Shirts',
                                ],
                                dropdownButtonProps: const DropdownButtonProps(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xff353535),
                                  ),
                                ),
                                onChanged: (value) {
                                  addProductCubit.category = value;
                                },
                                popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                    ),
                                    constraints:
                                        BoxConstraints(maxHeight: 200.0.h)),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    hintText:
                                        add_new_product_screen.department.tr(),
                                    hintStyle: AppTheme.textTheme.displaySmall
                                        ?.copyWith(
                                      color: AppColors.grey500.withOpacity(.17),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                      borderSide: BorderSide(
                                        color: AppColors.grey500
                                            .withOpacity(.17)
                                            .withOpacity(.17),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يجب إختيار القسم';
                                  }
                                  return null;
                                },
                              ),
                              Constatnts.height16,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: add_new_product_screen
                                          .second_department
                                          .tr(),
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff121725),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '* ',
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Constatnts.height8,
                              DropdownSearch<String>(
                                selectedItem: addProductCubit.subCategory,
                                clearButtonProps:
                                    const ClearButtonProps(isVisible: false),
                                items: const [
                                  'Hand bags',
                                  'Shirts',
                                  'T-Shirts',
                                ],
                                dropdownButtonProps: const DropdownButtonProps(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xff353535),
                                  ),
                                ),
                                popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                    ),
                                    constraints:
                                        BoxConstraints(maxHeight: 200.0.h)),
                                onChanged: (value) {
                                  addProductCubit.subCategory = value;
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    hintText: add_new_product_screen
                                        .second_department
                                        .tr(),
                                    hintStyle: AppTheme.textTheme.displaySmall
                                        ?.copyWith(
                                      color: AppColors.grey500.withOpacity(.17),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يجب إختيار القسم الفرعي';
                                  }
                                  return null;
                                },
                              ),
                              Constatnts.height16,
                              Text(
                                add_new_product_screen.product_price.tr(),
                                style:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Constatnts.height8,
                              customTextFeild(
                                controller: addProductCubit.priceController,
                                isTitleAviable: false,
                                hint: add_new_product_screen.product_price.tr(),
                                hintStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.lightGreyText,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.grey700,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                // padding:  EdgeInsets.symmetric(
                                //     horizontal: 0.0, vertical: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: add_new_product_screen.product_color
                                          .tr(),
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff121725),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Constatnts.height8,
                              DropdownSearch<String>(
                                selectedItem: '',
                                clearButtonProps:
                                    const ClearButtonProps(isVisible: false),
                                items: const [
                                  'red',
                                  'black',
                                  'orange',
                                  'blue',
                                  'brown',
                                ],
                                dropdownButtonProps: const DropdownButtonProps(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xff353535),
                                  ),
                                ),
                                onChanged: (value) {
                                  addProductCubit.addColor(value ?? '');
                                },
                                popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                    ),
                                    constraints:
                                        BoxConstraints(maxHeight: 150.0.h)),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    enabled: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              addProductCubit.product?.sizes == null
                                  ? Container()
                                  : Wrap(
                                      spacing: 10.0.w,
                                      runSpacing: 10.0.h,
                                      children: addProductCubit.product!.colors!
                                          .map(
                                            (color) => SelectedColorContainer(
                                              cubit: addProductCubit,
                                              color: color.name == 'red'
                                                  ? Colors.red
                                                  : color.name == 'black'
                                                      ? Colors.black
                                                      : color.name == 'orange'
                                                          ? Colors.orange
                                                          : color.name == 'blue'
                                                              ? Colors.blue
                                                              : Colors.brown,
                                            ),
                                          )
                                          .toList(),
                                    ),
                              addProductCubit.product?.sizes == null
                                  ? Container()
                                  : Constatnts.height16,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: add_new_product_screen.product_size
                                          .tr(),
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff121725),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Constatnts.height8,
                              DropdownSearch<String>(
                                selectedItem: '',
                                clearButtonProps:
                                    const ClearButtonProps(isVisible: false),
                                items: const [
                                  'S',
                                  'M',
                                  'L',
                                  'XL',
                                  'XXL',
                                ],
                                dropdownButtonProps: const DropdownButtonProps(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xff353535),
                                  ),
                                ),
                                onChanged: (value) {
                                  addProductCubit.addSize(value ?? '');
                                },
                                popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                    ),
                                    constraints:
                                        BoxConstraints(maxHeight: 150.0.h)),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    enabled: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              addProductCubit.product?.sizes == null
                                  ? Container()
                                  : Wrap(
                                      spacing: 10.0.w,
                                      runSpacing: 10.0.h,
                                      children: addProductCubit.product!.sizes!
                                          .map(
                                            (size) => SelectedSizeContainer(
                                              cubit: addProductCubit,
                                              size: size.name,
                                            ),
                                          )
                                          .toList(),
                                    ),
                              addProductCubit.product?.sizes == null
                                  ? Container()
                                  : Constatnts.height16,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: add_new_product_screen.product_words
                                          .tr(),
                                      style: AppTheme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff121725),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Constatnts.height8,
                              DropdownSearch<String>(
                                selectedItem: '',
                                clearButtonProps:
                                    const ClearButtonProps(isVisible: false),
                                items: const [
                                  'S',
                                  'M',
                                  'L',
                                  'XL',
                                  'XXL',
                                ],
                                dropdownButtonProps: const DropdownButtonProps(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xff353535),
                                  ),
                                ),
                                onChanged: (value) {
                                  addProductCubit.addWord(value ?? '');
                                },
                                popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                    ),
                                    constraints:
                                        BoxConstraints(maxHeight: 150.0.h)),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    enabled: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0.r),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.grey500.withOpacity(.17),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Constatnts.height16,
                              addProductCubit.product?.words == null
                                  ? Container()
                                  : Wrap(
                                      spacing: 10.0.w,
                                      runSpacing: 10.0.h,
                                      children: addProductCubit.product!.words!
                                          .map(
                                            (word) => SelectedWordsContainer(
                                              cubit: addProductCubit,
                                              word: word,
                                            ),
                                          )
                                          .toList(),
                                    ),
                              addProductCubit.product?.words == null
                                  ? Container()
                                  : Constatnts.height16,
                              Text(
                                add_new_product_screen.product_discreption.tr(),
                                style:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Constatnts.height8,
                              customTextFeild(
                                controller:
                                    addProductCubit.descriptionController,
                                isTitleAviable: false,
                                hint: add_new_product_screen.product_price.tr(),
                                hintStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.lightGreyText,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentStyle:
                                    AppTheme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.grey500.withOpacity(.17),
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                lines: 4,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (addProductCubit.isLoading)
                Container(
                  height: MediaQuery.sizeOf(context).height.h,
                  width: MediaQuery.sizeOf(context).width.w,
                  color: AppColors.grey25.withOpacity(.2),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * .16.h,
                      width: MediaQuery.sizeOf(context).width * .4.w,
                      child: const LoadingWidget(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
