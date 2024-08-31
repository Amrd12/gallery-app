import 'package:flutter/material.dart';

import '../../../constans/colors.dart';
import '../../../data/models/photo_model.dart';
import 'custom_icon.dart';
import 'custom_image.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.photo});
  final PhotoModel photo;
  Color get avColor =>
      Color(int.parse('FF${photo.avgColor.substring(1)}', radix: 16));
  void showimg(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SizedBox(
              width: width - 20,
              height: height - 20,
              child: GestureDetector(
                child: CustomImage(photo: photo, src: "original"),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: photo.width + 10 + 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.myWhite,
          border: Border.all(color: avColor, width: 7)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => showimg(context),
            child: GridTile(
              footer: CustomIcons(photo: photo),
              child: SizedBox(
                  width: photo.width,
                  height: photo.height,
                  child: CustomImage(photo: photo, src: "medium")),
            ),
          )),
    );
  }
}
