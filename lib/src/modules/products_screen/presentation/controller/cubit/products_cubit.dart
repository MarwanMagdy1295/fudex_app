import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kaf_app/src/app/di_service.dart';
import 'package:kaf_app/src/core/base_cubit/base_cubit.dart';
import 'package:kaf_app/src/core/services/hive_service.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/product_model.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/controller/cubit/products_state.dart';

class ProductsCubit extends BaseCubit<ProductsState>
    with
        AdaptiveCubit<ProductsState>,
        ResetLazySingleton<ProductsCubit, ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  TextEditingController searchController = TextEditingController();

  List<ProductModel?> products = [];
  bool isLoading = false;

  void clearSearch() {
    searchController.clear();
  }

  void getProductList(String key) {
    try {
      isLoading = true;
      emit(ProductsLoading());
      if (di<HiveService>().box.get(key) != null) {
        products = List<ProductModel>.from(di<HiveService>()
            .box
            .get(key)
            .map((x) => ProductModel.fromJson(x))
            .toList());
      }
      isLoading = false;
      emit(ProductsSuccess());
    } catch (e) {
      isLoading = false;
      emit(ProductsFailed());
      log(e.toString());
    }
  }
}
