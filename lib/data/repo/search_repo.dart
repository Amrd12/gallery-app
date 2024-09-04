import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../constans/strings.dart';
import '../api/search_api.dart';
import '../models/search_model.dart';
import 'photos_repo.dart';

class SearchRepo {
  final SearchApi _searchApi = locator.get<SearchApi>();

  PhotosRepo photosrepo = locator.get<PhotosRepo>();

  List<SearchModel> pareseSearch(List<dynamic> data) {
    return data.map((map) => SearchModel.fromMap(map)).toList();
  }

  Future<List<PhotoModel>> getSearchpage(String query, String type) async {
    if (query == "") return [];
    final data = await _searchApi.getSearch(query, type);
    SearchModel item = SearchModel(
        name: query,
        date: DateFormat('EEE, M/d/y').format(DateTime.now()).toString(),
        results: data["total_results"],
        type: type);
    final box = Hive.box<SearchModel>(HiveBoxNames.searchBox);
    box.add(item);
    item.save();
    return photosrepo.photosMapMap(data);
  }

  void nextpage() => _searchApi.nextpage();
}
