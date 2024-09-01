import 'package:gallaryapp/constans/strings.dart';
import 'package:gallaryapp/data/models/search_model.dart';
import 'package:gallaryapp/services/hive_manager/hive_manager.dart';

class SearchHiveManager extends HiveManager<SearchModel> {
  @override
  String get boxName => HiveBoxNames.searchBox;
}
