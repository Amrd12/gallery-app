import 'package:gallaryapp/data/api/network.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
import 'package:gallaryapp/services/primisions/request_permission.dart';

class PhotoHandeller {
  final PhotoHiveManager _manager = locator.get<PhotoHiveManager>();
  final Api _api = locator.get<Api>();
  Future<void> likePhoto(PhotoModel model) async => model.isInBox
      ? await _manager.removeFromBox(model)
      : await _manager.addToBox(model);

  //--------------------------------------------------------------------------

  // Future<void> downloadPhoto(PhotoModel model,
  //         {void Function(String?, double)? onProgress,
  //         void Function(String)? onDownloadCompleted,
  //         void Function(String)? onDownloadError}) async =>
  //     model.isDownloaded
  //         ? await _deletePhoto(model)
  //         : await _downloadPhoto(model,
  //             onProgress: onProgress,
  //             onDownloadCompleted: onDownloadCompleted,
  //             onDownloadError: onDownloadError);

  Future<void> downloadPhoto(PhotoModel model,
      {void Function(int, int)? onProgress,
      void Function(String)? onDownloadCompleted,
      void Function(String)? onDownloadError}) async {
    await requestPermission();
    if (model.isInBox == false) await _manager.addToBox(model);
    _api.saveimg(model, onreceve: onProgress);
    model.isDownloaded = true;
    model.save();
    onDownloadCompleted!(model.id.toString());
  }

  Future<void> deletePhoto(PhotoModel model) async {}
}
