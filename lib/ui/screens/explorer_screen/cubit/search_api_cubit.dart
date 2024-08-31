import '../../../../data/models/photo_model.dart';
import '../../../../data/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_api_state.dart';

class SearchApiCubit extends Cubit<SearchApiState> {
  SearchApiCubit() : super(SearchApiInitial());
  List<PhotoModel> photoResults = [];

  Searchrepo repo = Searchrepo();

  Future<List<PhotoModel>> getPhotosPage(String query, String type,
      {bool newsearch = false}) async {
    if (newsearch) {
      photoResults = [];
    }
    await repo.getSearchpage(query, type).then((photos) {
      photoResults.addAll(photos);
      emit(SearchApiSuccess(photoResults));
    });
    return photoResults;
  }

  nextpage() => repo.nextpage();
}
