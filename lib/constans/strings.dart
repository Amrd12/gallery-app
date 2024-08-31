// api
class ApiEndpoint {
  static const baseUrl = "https://api.pexels.com/v1/";
  static const curatedPhotos = "curated";
  static const search = "search";
}

// Storage
class StoragePath {
  static const dirTryFolder = "/storage/emulated/0/";
  static const dirFolder =
      "/storage/emulated/0/Android/data/com.example.gallaryapp/files/";
  static const folderName = 'gallaryapp';
}

// routs
class Routes {
  static const navigationRoute = "/";
  static const homeRoute = "/home";
  static const exploreRoute = "/explore";
  static const layoutRoute = "/layout";
}

//hive
class HiveBoxNames {
  static const hiveBox = "PhotosBox";
  static const searchBox = "searchbox";
}

//prefrence
class PrefNames {
  static const isdarkPref = "isdark";
  static const firstTimePref = "firsttime";
}
