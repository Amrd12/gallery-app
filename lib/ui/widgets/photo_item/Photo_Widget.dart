import 'package:flutter/material.dart';
import '../../../constans/colors.dart';
import '../../../data/models/Photo_Model.dart';
import 'Custom_Icon.dart';
import 'Custom_Image.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.photo});
  final PhotoModel photo;
  Color get av_color =>
      Color(int.parse('FF${photo.avg_color.substring(1)}', radix: 16));
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
          border: Border.all(color: av_color, width: 7)),
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
