import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/storage/storage.dart';

import '../api/curated_photos_api.dart';
import '../models/photo_model.dart';

class PhotosRepo {
  final Curatedphotosapi _curatedphotosapi = locator.get<Curatedphotosapi>();
  final Storage _storage = locator.get<Storage>();
  void nextpage() => _curatedphotosapi.nextpage();
  Future<List<PhotoModel>> photspage() async {
    final json = await _curatedphotosapi.photospage;
    return photosMap(json);
  }

  List<PhotoModel> photosMap(Map<String, dynamic> js) {
    List<PhotoModel> photos = List<PhotoModel>.from(
      (js["photos"] as List).map(_photoObj),
    );
    // Using Future.wait to handle asynchronous operations
    photos = photos.map((PhotoModel item) {
      item.isdownloaded = _storage.isdownloaded(item.id.toString());
      return item;
    }).toList();

    return photos;
  }

  _photoObj(item) {
    Map<String, dynamic> srcDynamicMap = item["src"] as Map<String, dynamic>;
    Map<String, String> srcStringMap =
        srcDynamicMap.map((key, value) => MapEntry(key, value.toString()));

    item["src"] = srcStringMap;
    item["isdownloaded"] = false;
    return PhotoModel.fromMap(item);
  }
}
