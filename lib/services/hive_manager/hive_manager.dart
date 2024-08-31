import 'dart:js_interop';

import 'package:hive/hive.dart';

abstract class HiveManager<T> {
  String get boxName;

  T? getIfSaved(T m) {
    final box = Hive.box<T>(boxName);
    return box.values.firstWhere(
        (test) => (test as dynamic)?.id == (m as dynamic)?.id,
        orElse: () => m);
  }

  bool isSaved(T m) {
    final box = Hive.box<T>(boxName);
    return box.values.contains(m);
  }

  List<T> getAllSaved() => Hive.box<T>(boxName).values.toList();

  Future<void> addToBox(T m) async => await Hive.box<T>(boxName).add(m);

  Future<void> removeFromBox(T m) async => await Hive.box<T>(boxName).delete(m);

  Future<void> addAll(Iterable<T> m) async =>
      await Hive.box<T>(boxName).addAll(m);
}
