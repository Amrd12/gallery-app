import 'package:gallaryapp/data/api/curated_photos_api.dart';
import 'package:gallaryapp/data/api/network.dart';
import 'package:gallaryapp/data/api/search_api.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
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
  // locator.registerFactory<Curatedphotosapi>(() => Curatedphotosapi());
  // locator.registerFactory<Curatedphotosapi>(() => Curatedphotosapi());
  locator.registerLazySingleton<SharedPref>(() => SharedPref());
}
