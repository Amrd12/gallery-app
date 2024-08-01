import 'package:flutter/material.dart';

class OrientationModel {
  ValueNotifier<int> item = ValueNotifier<int>(0);
  final List<String> _orientationList = ["", "landscape", "portrait", "square"];

  final _orientationIcons = {
    "": const Icon(Icons.not_interested),
    "landscape": const Icon(Icons.landscape),
    "portrait": const Icon(Icons.portrait),
    "square": const Icon(Icons.photo),
  };

  String get mode => _orientationList[item.value];
  Widget get icon => _orientationIcons[_orientationList[item.value]]!;

  void nextItem() {
    item.value = (item.value + 1) % _orientationList.length;
  }

  set mode(String newMode) {
    int index = _orientationList.indexOf(newMode);
    if (index != -1) {
      item.value = index;
    } else {
      throw ArgumentError("Invalid mode: $newMode");
    }
  }
}
