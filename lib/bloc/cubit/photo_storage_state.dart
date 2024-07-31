part of 'photo_storage_cubit.dart';

@immutable
sealed class PhotoStorageState {}

final class PhotoStorageInitial extends PhotoStorageState {}

final class PhotoStorageLoaded extends PhotoStorageState {
  final List<PhotoModel> photos;
  PhotoStorageLoaded(this.photos);
}
