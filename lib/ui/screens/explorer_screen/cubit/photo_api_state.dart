part of "photo_api_cubit.dart";

sealed class PhotoApiState {}

final class PhotoApiInitial extends PhotoApiState {}

final class PhotoApiLoaded extends PhotoApiState {
  final List<PhotoModel> photos;
  PhotoApiLoaded(this.photos);
}
