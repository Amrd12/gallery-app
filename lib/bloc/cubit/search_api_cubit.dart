import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/Photo_Model.dart';
import '../../data/repo/searchRepo.dart';

part 'search_api_state.dart';

class SearchApiCubit extends Cubit<SearchApiState> {
  SearchApiCubit() : super(SearchApiInitial());
  List<PhotoModel> PhotoResults = [];

  Searchrepo repo = Searchrepo();

  Future<List<PhotoModel>> getPhotosPage(String query, String type,
      {bool newsearch = false}) async {
    if (newsearch) {
      PhotoResults = [];
    }
    await repo.getSearchpage(query, type).then((photos) {
      PhotoResults.addAll(photos);
      emit(SearchApiSuccess(PhotoResults));
    });
    return PhotoResults;
  }

  nextpage() => repo.nextpage();
}
