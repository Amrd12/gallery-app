import 'dart:developer';

import 'package:gallaryapp/services/Storage/Storage.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'photo_storage_state.dart';

class PhotoStorageCubit extends Cubit<PhotoStorageState> {
  PhotoStorageCubit() : super(PhotoStorageInitial());
  final Storage storage = const Storage();

  List<PhotoModel> photos = [];
  List<PhotoModel> searchphotos = [];

  List<PhotoModel> getPhotosPage() {
    log("Success ========================");
    photos = [];
    photos.addAll(storage.savedimg);
    emit(PhotoStorageLoaded(photos));
    return photos;
  }

  List<PhotoModel> searchPhotosPage(String search) {
    searchphotos = photos.where((test) => test.alt.contains(search)).toList();
    emit(PhotoStorageLoaded(searchphotos));
    return searchphotos;
  }
}
