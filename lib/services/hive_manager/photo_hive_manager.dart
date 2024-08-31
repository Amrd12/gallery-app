import 'package:gallaryapp/constans/strings.dart';
import 'package:gallaryapp/services/hive_manager/hive_manager.dart';

class PhotoHiveManager extends HiveManager {
  @override
  // TODO: implement boxName
  String get boxName => HiveBoxNames.hiveBox;
}
