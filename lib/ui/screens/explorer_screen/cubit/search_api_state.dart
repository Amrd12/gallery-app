part of 'search_api_cubit.dart';

sealed class SearchApiState {}

final class SearchApiInitial extends SearchApiState {}

final class SearchApiSuccess extends SearchApiState {
  final List<PhotoModel> photos;
  SearchApiSuccess(this.photos);
}
