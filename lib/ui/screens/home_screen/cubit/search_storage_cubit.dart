import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/data/models/search_model.dart';
import 'package:gallaryapp/data/repo/search_repo.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/hive_manager/search_hive_manager.dart';

part 'search_storage_state.dart';

class SearchStorageCubit extends Cubit<SearchStorageState> {
  List<SearchModel> searchSugg = [];
  final SearchRepo repo = locator.get<SearchRepo>();
  final SearchHiveManager _manager = locator.get<SearchHiveManager>();

  SearchStorageCubit() : super(SearchStorageInitial());

  List<SearchModel> getSearchSugg(String text) {
    log("Success ========================");
    searchSugg = [];
    searchSugg.addAll(
        _manager.getAllSaved().where((test) => test.name.contains(text)));
    emit(SearchStorageSuccess(search: searchSugg));
    return searchSugg;
  }

  void nextpage() => repo.nextpage();
}
