import 'dart:io';

import 'package:kaf_app/src/modules/products_screen/data/models/color_model.dart';
import 'package:kaf_app/src/modules/products_screen/data/models/size_model.dart';

class ProductModel {
  int? id;
  String? name;
  File? mainImage;
  List<String>? images;
  List<SizeModel>? sizes;
  List<ColorModel>? colors;
  List<String>? words;
  String? mainDepartment;
  String? secondDepartment;
  String? price;
  String? description;

  ProductModel({
    this.id,
    this.name,
    this.sizes,
    this.colors,
    this.price,
    this.description,
    this.mainImage,
    this.images,
    this.mainDepartment,
    this.secondDepartment,
    this.words,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        sizes: List<SizeModel>.from(
            json['sizes'].map((x) => SizeModel.fromJson(x))),
        colors: List<ColorModel>.from(
            json['colors'].map((x) => ColorModel.fromJson(x))),
        price: json['price'],
        description: json['description'],
        mainImage: json['mainImage'],
        images: json['images'].cast<String>(),
        mainDepartment: json['mainDepartment'],
        secondDepartment: json['secondDepartment'],
        words: json['words'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sizes': List<dynamic>.from(sizes!.map((x) => x.toJson())),
        'colors': List<dynamic>.from(colors!.map((x) => x.toJson())),
        'price': price,
        'description': description,
        'mainImage': mainImage,
        'images': images,
        'mainDepartment': mainDepartment,
        'secondDepartment': secondDepartment,
        'words': words,
      };
}
