import 'package:flutter/material.dart';
import '../../data/models/Photo_Model.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({super.key, required this.photo});
  final PhotoModel photo;
  Color get av_color =>
      Color(int.parse('FF${photo.avg_color.substring(1)}', radix: 16));
  @override
  Widget build(BuildContext context) {
    return Image.network(
      photo.src["original"]!,
      fit: BoxFit.cover,
      loadingBuilder: _loadingImage,
    );
  }

  Widget _loadingImage(context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child; // Image has loaded
    } else {
      // Calculate progress
      double progress = loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              (loadingProgress.expectedTotalBytes ?? 1)
          : 0.0;

      return Center(
        heightFactor: 50,
        child: CircularProgressIndicator(value: progress, color: av_color),
      );
    }
  }
}
