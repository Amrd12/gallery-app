import 'package:gallaryapp/data/api/searchAPi.dart';
import 'package:gallaryapp/data/repo/photosrepo.dart';
import 'package:intl/intl.dart';

import '../../constans/strings.dart';
import '../models/Photo_Model.dart';
import '../models/Search_Model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Searchrepo extends SearchApi {
  PhotosRepo photosrepo = PhotosRepo();
  List<SearchModel> get search =>
      Hive.box<SearchModel>(searchBox).values.toList();

  Future<List<PhotoModel>> getSearchpage(String query, String type) async {
    if (query == "") return [];
    final data = await getSearch(query, type);
    SearchModel item = SearchModel(
        name: query,
        date: DateFormat('EEE, M/d/y').format(DateTime.now()).toString(),
        results: data["total_results"],
        type: type);
    final box = Hive.box<SearchModel>(searchBox);
    box.add(item);
    item.save();
    return photosrepo.PhotosMap(data);
  }
}
