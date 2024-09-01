import 'dart:developer';

import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
part 'photo_storage_state.dart';

class PhotoStorageCubit extends Cubit<PhotoStorageState> {
  PhotoStorageCubit() : super(PhotoStorageInitial());

  List<PhotoModel> photos = [];
  List<PhotoModel> searchphotos = [];
  final PhotoHiveManager _manager = locator.get<PhotoHiveManager>();
  List<PhotoModel> getPhotosPage() {
    log("Success ========================");
    photos = [];
    photos.addAll(_manager.getAllSaved());
    emit(PhotoStorageLoaded(photos));
    return photos;
  }

  List<PhotoModel> searchPhotosPage(String search) {
    searchphotos = photos.where((test) => test.alt.contains(search)).toList();
    emit(PhotoStorageLoaded(searchphotos));
    return searchphotos;
  }

  void addPhoto(PhotoModel model) {
    if (model.isInBox) {
      if (photos.contains(model)) {
        log("Photo removed ${model.alt}");
        photos.removeWhere((test) => test == model);
      }
    } else {
      if (!photos.contains(model)) {
        log("Photo Added ${model.alt}");
        photos.add(model);
      }
    }
    emit(PhotoStorageLoaded(photos));
  }
}
