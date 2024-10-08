import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/photo_model.dart';
import '../main_widgets/photo_item/Photo_Widget.dart';

class CustomPhotoList extends StatelessWidget {
  const CustomPhotoList(
      {super.key, required this.photos, this.scrollController});

  final List<PhotoModel> photos;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (photos.isEmpty) {
      return Center(
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 3,
          context.tr("empty"),
          style: const TextStyle(fontSize: 30),
        ),
      );
    } else {
      return GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width ~/ 300,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GridviewListItem(photos: photos[index]);
        },
      );
    }
  }
}

class GridviewListItem extends StatefulWidget {
  const GridviewListItem({
    super.key,
    required this.photos,
  });

  final PhotoModel photos;

  @override
  State<GridviewListItem> createState() => _GridviewListItemState();
}

class _GridviewListItemState extends State<GridviewListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: PhotoWidget(photo: widget.photos),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
