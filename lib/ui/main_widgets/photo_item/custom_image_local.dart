import 'package:flutter/material.dart';
import '../../../services/Storage/Storage.dart';
import '../../../data/models/photo_model.dart';

class CustomImageLocal extends StatelessWidget {
  const CustomImageLocal({super.key, required this.photo});

  final PhotoModel photo;
  Color get avColor =>
      Color(int.parse('FF${photo.avgColor.substring(1)}', radix: 16));

  @override
  Widget build(BuildContext context) {
    return Image.file(
      const Storage().imageFile(photo.id.toString()),
      fit: BoxFit.cover,
    );
  }
}
