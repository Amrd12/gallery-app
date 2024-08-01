import 'package:flutter/material.dart';
import '../../data/models/Photo_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork(
      {super.key, required this.photo, this.src = "small"});
  final PhotoModel photo;
  final String? src;
  Color get av_color =>
      Color(int.parse('FF${photo.avg_color.substring(1)}', radix: 16));
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photo.src[src]!,
      fit: BoxFit.cover,
      progressIndicatorBuilder: _loadingImage,
    );
  }

  Widget _loadingImage(context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child; // Image has loaded
    } else {
      // Calculate progress
      double progress = loadingProgress.progress != null
          ? loadingProgress.downloaded / (loadingProgress.totalSize ?? 1)
          : 0.0;

      return Center(
        heightFactor: 50,
        child: CircularProgressIndicator(value: progress, color: av_color),
      );
    }
  }
}
