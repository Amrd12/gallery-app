import 'package:flutter/material.dart';

enum OrientationMode {
  none,
  landscape,
  portrait,
  square,
}

extension OrientationModeExtension on OrientationMode {
  String get name {
    switch (this) {
      case OrientationMode.none:
        return "";
      case OrientationMode.landscape:
        return "landscape";
      case OrientationMode.portrait:
        return "portrait";
      case OrientationMode.square:
        return "square";
    }
  }

  IconData get icon {
    switch (this) {
      case OrientationMode.none:
        return Icons.not_interested;
      case OrientationMode.landscape:
        return Icons.landscape;
      case OrientationMode.portrait:
        return Icons.portrait;
      case OrientationMode.square:
        return Icons.square;
    }
  }
}

extension OrientationModeStringExtension on String {
  OrientationMode toOrientationMode() {
    switch (this) {
      case "landscape":
        return OrientationMode.landscape;
      case "portrait":
        return OrientationMode.portrait;
      case "square":
        return OrientationMode.square;
      default:
        return OrientationMode.none;
    }
  }
}
