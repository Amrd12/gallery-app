import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../constans/strings.dart';
import '../../data/models/photo_model.dart';

class Storage {
  const Storage();
  Future<void> makeBaseDirectory() async {
    Directory? baseDir;
    if (Platform.isAndroid) {
      baseDir = await getDownloadsDirectory();
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
    log("Base Dir:  ${baseDir.path}");
    return baseDir.path;
  }

  bool isDownloaded(String id) {
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
    photo.isDownloaded = false;
    photo.save();
  }

  Future<void> saveDataToFile(String filePath, String data) async {
    final file = File(filePath);
    await file.writeAsString(data);
  }
}
