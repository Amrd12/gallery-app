import '../../Storage/Storage.dart';
import '../api/curatedphotosAPi.dart';
import '../models/Photo_Model.dart';

class PhotosRepo extends Curatedphotosapi {
  final Storage storage = const Storage();

  Future<List<PhotoModel>> photspage() async {
    final js = await photospage;
    return PhotosMap(js);
  }

  List<PhotoModel> PhotosMap(Map<String, dynamic> js) {
    List<PhotoModel> photos = List<PhotoModel>.from(
      (js["photos"] as List).map(_photoObj),
    );
    // Using Future.wait to handle asynchronous operations
    photos = photos.map((PhotoModel item) {
      item.isdownloaded = storage.isdownloaded(item.id.toString());
      item.Like = storage.isLiked(item.id);
      return item;
    }).toList();

    return photos;
  }

  _photoObj(item) {
    Map<String, dynamic> srcDynamicMap = item["src"] as Map<String, dynamic>;
    Map<String, String> srcStringMap =
        srcDynamicMap.map((key, value) => MapEntry(key, value.toString()));

    item["src"] = srcStringMap;
    item["Like"] = false;
    item["isdownloaded"] = false;
    return PhotoModel.fromMap(item);
  }
}
