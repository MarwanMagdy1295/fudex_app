import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late final dynamic _box;

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('productBox');
    _box = Hive.box('productBox');
  }

  final box = const BoxData();
}

class BoxData extends _BoxField<String, dynamic> {
  const BoxData() : super();
}

class _BoxField<String, T> {
  const _BoxField();

  Future write(String key, T value) async {
    return HiveService._box.put(key, value);
  }

  T? get(String key) {
    try {
      return HiveService._box.get(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete() {
    return HiveService._box.delete();
  }
}
