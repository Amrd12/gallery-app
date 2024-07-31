import 'package:flutter/material.dart';
import '../../data/models/Photo_Model.dart';
import 'Photo_Widget.dart';

class CustomPhotoList extends StatefulWidget {
  CustomPhotoList({super.key, required this.photos, this.onPressed});
  final List<PhotoModel> photos;
  final VoidCallback? onPressed;

  @override
  State<CustomPhotoList> createState() => _CustomPhotoListState();
}

class _CustomPhotoListState extends State<CustomPhotoList> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    if (widget.onPressed != null) {
      _scrollController = ScrollController();
      _scrollController!.addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    if (widget.onPressed != null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onPressed != null || widget.photos.isEmpty == false) {
        if (_scrollController!.position.maxScrollExtent < height)
          widget.onPressed!();
      }
    });

    if (widget.photos.isEmpty) {
      return const Center(
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 3,
          "Empty ,please Add some Photos",
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width ~/ 300),
        itemCount: widget.photos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: PhotoWidget(photo: widget.photos[index]),
          );
        },
      );
    }
  }

  void _scrollListener() {
    if (_scrollController!.position.pixels >=
        _scrollController!.position.maxScrollExtent - 50) {
      widget.onPressed!();
    }
  }
}
