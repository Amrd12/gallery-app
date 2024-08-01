import 'package:bloc/bloc.dart';
import 'package:gallaryapp/data/models/Search_Model.dart';
import 'package:gallaryapp/data/repo/searchRepo.dart';
import 'package:meta/meta.dart';

part 'search_storage_state.dart';

class SearchStorageCubit extends Cubit<SearchStorageState> {
  List<SearchModel> SearchSugg = [];
  Searchrepo repo = Searchrepo();
  SearchStorageCubit() : super(SearchStorageInitial());

  List<SearchModel> getSearchSugg(String text) {
    print("Success ========================");
    SearchSugg = [];
    SearchSugg.addAll(repo.search.where((test) => test.name.contains(text)));
    emit(SearchStorageSuccess(search: SearchSugg));
    return SearchSugg;
  }

  void nextpage() => repo.nextpage();
}
