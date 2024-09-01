import 'package:gallaryapp/constans/strings.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/services/hive_manager/hive_manager.dart';

class PhotoHiveManager extends HiveManager<PhotoModel> {
  @override
  String get boxName => HiveBoxNames.hiveBox;
}
