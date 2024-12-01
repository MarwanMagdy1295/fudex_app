class SizeModel {
  String? name;
  bool? isSelected;

  SizeModel({
    this.name,
    this.isSelected,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        name: json['name'],
        isSelected: json['isSelected'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'isSelected': isSelected,
      };
}
