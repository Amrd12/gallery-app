part of 'search_storage_cubit.dart';

sealed class SearchStorageState {}

final class SearchStorageInitial extends SearchStorageState {}

final class SearchStorageSuccess extends SearchStorageState {
  final List<SearchModel> search;

  SearchStorageSuccess({required this.search});
}
