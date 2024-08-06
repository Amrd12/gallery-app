import 'package:flutter/material.dart';
import '../../../Storage/Storage.dart';
import '../../../data/models/Photo_Model.dart';

class CustomImageLocal extends StatelessWidget {
  const CustomImageLocal({super.key, required this.photo});

  final PhotoModel photo;
  Color get av_color =>
      Color(int.parse('FF${photo.avg_color.substring(1)}', radix: 16));

  @override
  Widget build(BuildContext context) {
    return Image.file(
      const Storage().imageFile(photo.id.toString()),
      fit: BoxFit.cover,
    );
  }
}
