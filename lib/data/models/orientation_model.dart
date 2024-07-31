import 'package:flutter/material.dart';

class OrientationModel {
  ValueNotifier<int> item = ValueNotifier<int>(0);
  final List<String> _orientationList = ["", "landscape", "portrait", "square"];

  final _orientationIcons = {
    "": Icon(Icons.not_interested),
    "landscape": Icon(Icons.landscape),
    "portrait": Icon(Icons.portrait),
    "square": Icon(Icons.photo),
  };

  String get mode => _orientationList[item.value];
  Widget get icon => _orientationIcons[_orientationList[item.value]]!;

  void nextItem() {
    item.value = (item.value + 1) % _orientationList.length;
  }

  void set mode(String newMode) {
    int index = _orientationList.indexOf(newMode);
    if (index != -1) {
      item.value = index;
    } else {
      throw ArgumentError("Invalid mode: $newMode");
    }
  }
}
