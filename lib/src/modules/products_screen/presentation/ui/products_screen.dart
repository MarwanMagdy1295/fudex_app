import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/core/utils/constants.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/ui/add_product_screen.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/components/product_card.dart';
import 'package:kaf_app/src/core/utils/assets/translations/keys.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/controller/cubit/products_cubit.dart';
import 'package:kaf_app/widget/custom_button.dart';
import 'package:kaf_app/widget/custom_text_form_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kaf_app/widget/loading_widget.dart';
// import 'dart:ui' as ui;

class ProductsScreen extends HookWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      lazy: true,
      create: (context) => ProductsCubit()..getProductList('bags'),
      child: HookBuilder(builder: (context) {
        final productCubit = context.read<ProductsCubit>();
        ValueNotifier<bool> updateList = useState(false);
        // useWillMount(() {
        // controller.refresh();
        // });
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.black.withOpacity(.5),
            elevation: 1,
            systemOverlayStyle: const SystemUiOverlayStyle(),
            leading:
                const Icon(Icons.arrow_back_rounded, color: AppColors.black),
            title: Text(
              products_screen.products.tr(),
              style: AppTheme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
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
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
                if (result != null && result == true) {
                  productCubit.getProductList('bags');
                  updateList.value = true;
                }
              },
              title: products_screen.add_product.tr(),
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
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 24.0.w,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 60.0.h),
                      child: Column(
                        children: [
                          Constatnts.height16,
                          AspectRatio(
                            aspectRatio: 5.6.h,
                            child: customTextFeild(
                              controller: productCubit.searchController,
                              isTitleAviable: false,
                              hint: products_screen.search.tr(),
                              hintStyle:
                                  AppTheme.textTheme.displaySmall?.copyWith(
                                color: AppColors.lightGreyText,
                                fontWeight: FontWeight.w400,
                              ),
                              contentStyle:
                                  AppTheme.textTheme.displaySmall?.copyWith(
                                color: AppColors.grey500,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0.r),
                                borderSide: const BorderSide(
                                  color: AppColors.grey,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 22.0,
                                color: AppColors.darkGrey,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  productCubit.clearSearch();
                                },
                                child: const Icon(Icons.cancel_rounded,
                                    color: AppColors.grey300),
                              ),
                            ),
                          ),
                          Constatnts.height16,
                          DropdownSearch<String>(
                            selectedItem: 'bags',
                            clearButtonProps:
                                const ClearButtonProps(isVisible: false),
                            items: const [
                              'bags',
                              'T-Shirts',
                            ],
                            dropdownButtonProps: const DropdownButtonProps(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.grey500,
                              ),
                            ),
                            popupProps: PopupProps.menu(
                                menuProps: MenuProps(
                                  backgroundColor: AppColors.grey25,
                                  borderRadius: BorderRadius.circular(12.0.r),
                                ),
                                constraints:
                                    BoxConstraints(maxHeight: 200.0.h)),
                            onChanged: (value) {
                              if (value != null) {
                                productCubit.getProductList(value);
                                updateList.value = true;
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                hintText: products_screen.department.tr(),
                                hintStyle:
                                    AppTheme.textTheme.headlineMedium?.copyWith(
                                  color: AppColors.grey500,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          productCubit.products.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 16.0.h),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .02.h),
                                  itemCount: productCubit.products.length,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                      product: productCubit.products[index]!,
                                    );
                                  },
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.4.h,
                                  child: Center(
                                    child: Text(
                                      'Please add new product',
                                      style: AppTheme.textTheme.headlineSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                          Constatnts.height60,
                        ],
                      ),
                    ),
                  ),
                ),
                if (productCubit.isLoading)
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
            ),
          ),
        );
      }),
    );
  }
}
