import 'package:flutter/material.dart';

import '../../../services/Storage/Storage.dart';
import '../../../data/models/photo_model.dart';
import 'Custom_Image_Local.dart';
import 'custom_image_network.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.photo, this.src});
  final String? src;
  final PhotoModel photo;
  Color get avColor =>
      Color(int.parse('FF${photo.avgColor.substring(1)}', radix: 16));
  @override
  Widget build(BuildContext context) {
    return (photo.isdownloaded ||
            const Storage().isdownloaded(photo.id.toString()))
        ? CustomImageLocal(photo: photo)
        : CustomImageNetwork(photo: photo, src: src!);
  }
}
