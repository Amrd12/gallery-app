import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/data/repo/photos_repo.dart';
import 'package:gallaryapp/locator.dart';

part "photo_api_state.dart";

class PhotoApiCubit extends Cubit<PhotoApiState> {
  final PhotosRepo repo = locator.get<PhotosRepo>();

  List<PhotoModel> photos = [];

  PhotoApiCubit() : super(PhotoApiInitial());

  Future<List<PhotoModel>> getPhotosPage() async {
    await repo.photspage().then((photos) {
      log("Success ========================");
      this.photos.addAll(photos);
      emit(PhotoApiLoaded(this.photos));
    });
    return photos;
  }

  nextpage() => repo.nextpage();
}
