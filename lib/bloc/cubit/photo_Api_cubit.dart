import 'package:bloc/bloc.dart';
import '../../data/models/Photo_Model.dart';
import '../../data/repo/photosrepo.dart';
import 'package:meta/meta.dart';

part 'photo_Api_state.dart';

class PhotoApiCubit extends Cubit<PhotoApiState> {
  final PhotosRepo repo = PhotosRepo();

  List<PhotoModel> photos = [];

  PhotoApiCubit() : super(PhotoApiInitial());

  Future<List<PhotoModel>> getPhotosPage() async {
    await repo.photspage().then((photos) {
      print("Success ========================");
      this.photos.addAll(photos);
      emit(PhotoApiLoaded(this.photos));
    });
    return this.photos;
  }

  nextpage() => repo.nextpage();
}
