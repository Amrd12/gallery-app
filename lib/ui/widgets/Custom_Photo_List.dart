import 'package:flutter/material.dart';
import '../../data/models/Photo_Model.dart';
import 'Photo_Widget.dart';

class CustomPhotoList extends StatelessWidget {
  const CustomPhotoList(
      {super.key, required this.photos, this.scrollController});

  final List<PhotoModel> photos;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (photos.isEmpty) {
      return const Center(
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 3,
          "Empty, please Add some Photos",
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return SingleChildScrollView(
        controller: scrollController,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width ~/ 300,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: PhotoWidget(photo: photos[index]),
              );
            },
          ),
        ),
      );
    }
  }
}
