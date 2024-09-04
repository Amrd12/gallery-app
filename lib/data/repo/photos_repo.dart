import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
import 'package:gallaryapp/services/storage/storage.dart';

import '../api/curated_photos_api.dart';
import '../models/photo_model.dart';

class PhotosRepo {
  final Curatedphotosapi _curatedphotosapi = locator.get<Curatedphotosapi>();

  final Storage _storage = locator.get<Storage>();

  final PhotoHiveManager _manager = locator.get<PhotoHiveManager>();

  void nextpage() => _curatedphotosapi.nextpage();

  Future<List<PhotoModel>> photspage() async {
    final json = await _curatedphotosapi.photospage;
    return photosMapMap(json);
  }

  List<PhotoModel> photosMapMap(Map<String, dynamic> js) {
    return (js["photos"] as List).map<PhotoModel>((dynamic item) {
      PhotoModel photo = _photoObj(item);
      photo = _manager.getIfSaved(photo) ?? photo;
      photo.isDownloaded = _storage.isDownloaded(photo.id.toString());
      return photo;
    }).toList();
  }

  List<PhotoModel> photosMapList(List<dynamic> js) =>
      js.map<PhotoModel>((dynamic item) {
        PhotoModel photo = _photoObj(item);
        photo = _manager.getIfSaved(photo) ?? photo;
        photo.isDownloaded = _storage.isDownloaded(photo.id.toString());
        return photo;
      }).toList();

  _photoObj(item) {
    Map<String, dynamic> srcDynamicMap = item["src"] as Map<String, dynamic>;
    Map<String, String> srcStringMap =
        srcDynamicMap.map((key, value) => MapEntry(key, value.toString()));

    item["src"] = srcStringMap;
    item["isDownloaded"] = false;
    return PhotoModel.fromMap(item);
  }
}
