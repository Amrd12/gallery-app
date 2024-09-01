import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/photo_handeller/photo_handeller.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/photo_storage_cubit.dart';
import '../../../services/Storage/Storage.dart';
import '../../../data/models/photo_model.dart';

class CustomIcons extends StatefulWidget {
  const CustomIcons({
    super.key,
    required this.photo,
  });
  final PhotoModel photo;

  @override
  State<CustomIcons> createState() => _CustomIconsState();
}

class _CustomIconsState extends State<CustomIcons> {
  bool downloading = false;
  double? progress;

  final Storage storage = const Storage();
  Color get avColor =>
      Color(int.parse('FF${widget.photo.avgColor.substring(1)}', radix: 16));

  final PhotoHandeller _photoHandeller = locator.get<PhotoHandeller>();

  _download(BuildContext context) async {
    if (!widget.photo.isInBox) {
      _fav();
    }
    if (widget.photo.isDownloaded) {
      _deletePhoto(context);
    } else {
      _startDownload();
    }
  }

  void _startDownload() async {
    setState(() {
      downloading = true;
      progress = 0.0;
    });

    await _photoHandeller.downloadPhoto(
      widget.photo,
      onProgress: (p0, p1) => _updateProgress(p0, p1),
      onDownloadCompleted: (p0) => _showSnackBar("Downloaded Success"),
      onDownloadError: (p0) => _showSnackBar("Downloaded Error : $p0"),
    );

    setState(() {
      log("Download completed _start");
      downloading = false;
      progress = 0.0;
    });
  }

  void _deletePhoto(BuildContext context) {
    setState(() {
      downloading = false;
    });
    storage.deleteimg(widget.photo);

    setState(() {});
  }

  void _fav() {
    //true
    //add or remove form storage
    BlocProvider.of<PhotoStorageCubit>(context).addPhoto(widget.photo);
    //add or remove from box
    _photoHandeller.likePhoto(widget.photo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var downloadedIcon = widget.photo.isDownloaded
        ? const Icon(Icons.download_done, size: 40, color: Colors.white)
        : const Icon(Icons.download, size: 40, color: Colors.white);

    var likedIcon = widget.photo.isInBox
        ? const Icon(Icons.favorite, size: 40, color: Colors.white)
        : const Icon(Icons.favorite_border, size: 40, color: Colors.white);

    return Container(
      color: avColor.withOpacity(.7),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          downloading
              ? CircularProgressIndicator(value: progress, color: Colors.white)
              : IconButton(
                  onPressed: () => _download(context),
                  icon: downloadedIcon,
                ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => _fav(),
            icon: likedIcon,
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: avColor,
    ));
  }

  void _updateProgress(int start, int end) {
    setState(() {
      progress = (start / end).clamp(0, 1);
    });
  }
}
