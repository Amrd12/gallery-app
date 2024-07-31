import 'package:bloc/bloc.dart';
import '../../Storage/Storage.dart';
import '../../data/models/Photo_Model.dart';
import 'package:meta/meta.dart';

part 'photo_storage_state.dart';

class PhotoStorageCubit extends Cubit<PhotoStorageState> {
  PhotoStorageCubit() : super(PhotoStorageInitial());
  final Storage storage = Storage();

  List<PhotoModel> photos = [];
  List<PhotoModel> searchphotos = [];

  List<PhotoModel> getPhotosPage() {
    print("Success ========================");
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
