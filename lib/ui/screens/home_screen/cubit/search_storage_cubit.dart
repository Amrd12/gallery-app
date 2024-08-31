import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/data/models/search_model.dart';
import 'package:gallaryapp/data/repo/search_repo.dart';

part 'search_storage_state.dart';

class SearchStorageCubit extends Cubit<SearchStorageState> {
  List<SearchModel> searchSugg = [];
  Searchrepo repo = Searchrepo();
  SearchStorageCubit() : super(SearchStorageInitial());

  List<SearchModel> getSearchSugg(String text) {
    log("Success ========================");
    searchSugg = [];
    searchSugg.addAll(repo.search.where((test) => test.name.contains(text)));
    emit(SearchStorageSuccess(search: searchSugg));
    return searchSugg;
  }

  void nextpage() => repo.nextpage();
}
