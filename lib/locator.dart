import 'package:gallaryapp/data/api/curated_photos_api.dart';
import 'package:gallaryapp/data/api/network.dart';
import 'package:gallaryapp/data/api/search_api.dart';
import 'package:gallaryapp/data/repo/photos_repo.dart';
import 'package:gallaryapp/data/repo/search_repo.dart';
import 'package:gallaryapp/services/backup/bakeup.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
import 'package:gallaryapp/services/hive_manager/search_hive_manager.dart';
import 'package:gallaryapp/services/photo_handeller/photo_handeller.dart';
import 'package:gallaryapp/services/shared_pref/shared_pref.dart';
import 'package:gallaryapp/services/storage/storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerFactory<Curatedphotosapi>(() => Curatedphotosapi());
  locator.registerFactory<Api>(() => Api());
  locator.registerFactory<Storage>(() => const Storage());
  locator.registerFactory<SearchApi>(() => SearchApi());
  locator.registerFactory<PhotoHiveManager>(() => PhotoHiveManager());
  locator.registerFactory<PhotoHandeller>(() => PhotoHandeller());
  locator.registerFactory<SearchHiveManager>(() => SearchHiveManager());
  locator.registerFactory<Backup>(() => Backup());
  locator.registerFactory<PhotosRepo>(() => PhotosRepo());
  locator.registerFactory<SearchRepo>(() => SearchRepo());

  locator.registerLazySingleton<SharedPref>(() => SharedPref());
}
