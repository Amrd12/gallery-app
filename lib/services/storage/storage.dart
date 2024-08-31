

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../constans/strings.dart';
import '../../data/models/photo_model.dart';

class Storage {
  const Storage();
  Future<void> makeBaseDirectory() async {
    Directory? baseDir;
    if (Platform.isAndroid) {
      baseDir = await getExternalStorageDirectory();
    } else {
      baseDir = Directory.current;
    }
    String folderPath = path.join(baseDir!.path, StoragePath.folderName);

    Directory folder = Directory(folderPath);

    if (!folder.existsSync()) {
      folder.createSync();
    }
  }

  String getBaseDirectory() {
    Directory? baseDir;
    if (Platform.isAndroid) {
      baseDir =
          Directory(path.join(StoragePath.dirFolder, StoragePath.folderName));
      if (!baseDir.existsSync()) {
        try {
          baseDir.createSync();
        } catch (e) {
          baseDir = Directory(
              path.join(StoragePath.dirFolder, StoragePath.folderName));
        }
      }
    } else {
      baseDir = Directory.current;
    }

    return baseDir.path;
  }

  List<PhotoModel> get savedimg =>
      Hive.box<PhotoModel>(HiveBoxNames.hiveBox).values.toList();

  bool isSaved(int id) => savedimg.where((text) => text.id == id).isEmpty;


  bool isdownloaded(String id) {
    final dic = getBaseDirectory();
    File img = File("$dic/$id.jpg");
    return img.existsSync();
  }

  File imageFile(String id) {
    final dic = getBaseDirectory();
    File img = File("$dic/$id.jpg");
    return img;
  }

  deleteimg(PhotoModel photo) {
    final dic = getBaseDirectory();
    File img = File("$dic/${photo.id}.jpg");
    img.deleteSync();
    photo.isdownloaded = false;
    if (photo.isInBox && photo.isInBox == false) photo.delete();
  }
}
