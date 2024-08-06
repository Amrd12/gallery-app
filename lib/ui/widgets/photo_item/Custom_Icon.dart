import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/photo_storage_cubit.dart';
import '../../../Storage/Storage.dart';
import '../../../constans/strings.dart';
import '../../../data/api/network.dart';
import '../../../data/models/Photo_Model.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  Color get av_color =>
      Color(int.parse('FF${widget.photo.avg_color.substring(1)}', radix: 16));

  _startDownload(BuildContext context) async {
    if (widget.photo.isdownloaded) {
      _downloaded(context);
    } else {
      _notdownloaded();
    }
  }

  void _notdownloaded() {
    setState(() {
      downloading = true;
      progress = 0.0;
    });
    Api().saveimg(widget.photo, onreceve: _updateProgress).then((_) {
      setState(() {
        downloading = false;
      });
    });
    return;
  }

  void _downloaded(BuildContext context) {
    setState(() {
      downloading = false;
    });
    storage.deleteimg(widget.photo);
    final ModalRoute? currentRoute = ModalRoute.of(context);
    if (currentRoute != null) {
      final RouteSettings settings = currentRoute.settings;
      if (settings.name == homeRoute) {
        context.read<PhotoStorageCubit>().getPhotosPage();
      }
    }
    setState(() {});

    return;
  }

  void _updateProgress(int start, int end) {
    setState(() {
      progress = (start / end).clamp(0, 1);
    });
  }

  void _fav(BuildContext context) {
    final box = Hive.box<PhotoModel>(hivebox);
    widget.photo.Like = !widget.photo.Like;
    if (widget.photo.Like && storage.isSaved(widget.photo.id)) {
      if (!widget.photo.isInBox) box.add(widget.photo);
      widget.photo.save();
    } else if (!widget.photo.Like && !widget.photo.isdownloaded) {
      widget.photo.delete();
      final ModalRoute? currentRoute = ModalRoute.of(context);
      if (currentRoute != null) {
        final RouteSettings settings = currentRoute.settings;
        if (settings.name == homeRoute) {
          context.read<PhotoStorageCubit>().getPhotosPage();
        }
      } else {
        print('No current route found.');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var DownloadedIcon = widget.photo.isdownloaded
        ? const Icon(Icons.download_done, size: 40, color: Colors.white)
        : const Icon(Icons.download, size: 40, color: Colors.white);

    var likedicon = widget.photo.Like
        ? const Icon(Icons.favorite, size: 40, color: Colors.white)
        : const Icon(Icons.favorite_border, size: 40, color: Colors.white);

    return Container(
      color: av_color.withOpacity(.7),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: !downloading,
            replacement: Center(
              heightFactor: 40,
              child: CircularProgressIndicator(
                  value: progress, color: Colors.white),
            ),
            child: IconButton(
              onPressed: () => _startDownload(context),
              icon: DownloadedIcon,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => _fav(context),
            icon: likedicon,
          ),
        ],
      ),
    );
  }
}
