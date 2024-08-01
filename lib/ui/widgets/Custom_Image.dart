import 'package:flutter/material.dart';
import 'package:gallaryapp/Storage/Storage.dart';
import '../../data/models/Photo_Model.dart';

import 'Custom_Image_Local.dart';
import 'Custom_Image_Network.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.photo, this.src});
  final String? src;
  final PhotoModel photo;
  Color get av_color =>
      Color(int.parse('FF${photo.avg_color.substring(1)}', radix: 16));
  @override
  Widget build(BuildContext context) {
    return (photo.isdownloaded || Storage().isdownloaded(photo.id.toString()))
        ? CustomImageLocal(photo: photo)
        : CustomImageNetwork(photo: photo, src: src);
  }
}
