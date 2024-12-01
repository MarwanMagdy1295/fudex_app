import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaf_app/src/app/di_service.dart';
import 'package:kaf_app/src/core/base_cubit/base_cubit.dart';
import 'package:kaf_app/src/core/services/hive_service.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_state.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/color_model.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/product_model.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/size_model.dart';

class AddProductCubit extends BaseCubit<AddProductState>
    with
        AdaptiveCubit<AddProductState>,
        ResetLazySingleton<AddProductCubit, AddProductState> {
  AddProductCubit() : super(AddProductStateInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? category = 'bags';
  String? subCategory = 'Hand bags';
  File? mainImage;
  ProductModel? product =
      ProductModel(colors: [], sizes: [], words: [], images: []);
  final formKey = GlobalKey<FormState>();
  List<File>? pickedImagesFromGallery = [];
  bool isLoading = false;

  Future<void> pickImageFromGallery(bool mainImg) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result == null) return;
    if (mainImg) {
      mainImage = File(result.path);
      // print('mainImage = $mainImage');
    } else {
      pickedImagesFromGallery?.add(File(result.path));
      // print('pickedXRayFile = $pickedImagesFromGallery');
    }

    emit(AddProductStateImageUploadSuccess());
  }

  void deleteImage({required bool mainImg, File? img}) {
    isLoading = true;
    emit(AddProductStateLoading());
    if (mainImg) {
      mainImage = null;
    } else {
      pickedImagesFromGallery?.removeWhere((i) => i == img);
    }
    isLoading = false;
    emit(AddProductStateSuccess());
  }

  void addProduct(BuildContext context) {
    if (formKey.currentState!.validate()) {
      product?.name = nameController.text;
      product?.price = priceController.text;
      product?.description = descriptionController.text;
      product?.mainDepartment = category;
      product?.secondDepartment = subCategory;
      product?.mainImage = mainImage;
      pickedImagesFromGallery?.forEach((i) {
        product?.images?.add(i.path);
      });

      // di<HiveService>().box.write('bags', [product?.toJson()]);

      // var data = di<HiveService>().box.get('bags');

      // print(data);
      // print(data.runtimeType);
      // // print(List<Map<dynamic, dynamic>>.from(data as List<dynamic>).toList());
      // print(List<ProductModel>.from(
      //         data.map((x) => ProductModel.fromJson(x)).toList())
      //     .first
      //     .name);

      saveProduct(context);
    }
  }

  void saveProduct(BuildContext context) {
    try {
      var storedData = [];
      if (di<HiveService>().box.get(product?.mainDepartment ?? 'bags') !=
          null) {
        storedData = List<ProductModel>.from(di<HiveService>()
            .box
            .get(product?.mainDepartment ?? 'bags')
            .map((x) => ProductModel.fromJson(x))
            .toList());
        storedData.add(product!);
        var covertedProductList =
            List<dynamic>.from(storedData.map((x) => x.toJson()));
        di<HiveService>()
            .box
            .write(product?.mainDepartment ?? 'bags', covertedProductList);
        // print(di<HiveService>().box.get('bags'));
        // print(List<ProductModel>.from(di<HiveService>()
        //         .box
        //         .get('bags')
        //         .map((x) => ProductModel.fromJson(x))
        //         .toList())
        //     .last
        //     .name);
      } else {
        storedData.add(product!);
        var covertedProductList =
            List<dynamic>.from(storedData.map((x) => x.toJson()));
        di<HiveService>()
            .box
            .write(product?.mainDepartment ?? 'bags', covertedProductList);
        // print(di<HiveService>().box.get('bags'));
      }
      Navigator.pop(context, true);
    } catch (e) {
      log(e.toString());
    }
  }

  void addColor(String color) {
    var contained = product?.colors?.any((c) => c.name == color) ?? false;
    if (!contained) {
      product?.colors?.add(ColorModel(name: color, isSelected: true));
    }
    emit(AddProductStateSuccess());
  }

  void addSize(String size) {
    var contained = product?.sizes?.any((s) => s.name == size) ?? false;
    if (!contained) {
      product?.sizes?.add(SizeModel(name: size, isSelected: true));
    }
    emit(AddProductStateSuccess());
  }

  void addWord(String word) {
    var contained = product?.words?.any((w) => w == word) ?? false;
    if (!contained) {
      product?.words?.add(word);
    }
    emit(AddProductStateSuccess());
  }
}
