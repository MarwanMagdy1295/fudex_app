class ColorModel {
  String? name;
  bool? isSelected;

  ColorModel({
    this.name,
    this.isSelected,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        name: json['name'],
        isSelected: json['isSelected'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'isSelected': isSelected,
      };
}
