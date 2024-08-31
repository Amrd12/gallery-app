import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';

class PhotoHandeller {
  final PhotoHiveManager _manager = locator.get<PhotoHiveManager>();

  Future<void> likePhoto(PhotoModel model) async =>
      model.isInBox ? await _dislikePhoto(model) : await _likePhoto(model);

  Future<void> _likePhoto(PhotoModel model) async =>
      await _manager.addToBox(model);
  Future<void> _dislikePhoto(PhotoModel model) async =>
      await _manager.removeFromBox(model);

  //--------------------------------------------------------------------------
  void downloadPhoto(PhotoModel model) =>
      model.isdownloaded ? _deletePhoto(model) : _downloadPhoto(model);
  void _downloadPhoto(PhotoModel model) {}
  void _deletePhoto(PhotoModel model) {}
}
