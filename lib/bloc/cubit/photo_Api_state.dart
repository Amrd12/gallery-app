part of 'photo_Api_cubit.dart';

@immutable
sealed class PhotoApiState {}

final class PhotoApiInitial extends PhotoApiState {}

final class PhotoApiLoaded extends PhotoApiState {
  final List<PhotoModel> photos;
  PhotoApiLoaded(this.photos);
}
