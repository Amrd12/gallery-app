import 'dart:developer';

import 'package:gallaryapp/locator.dart';

import '../../constans/strings.dart';
import 'network.dart';

class Curatedphotosapi {
  final Api _api = locator.get<Api>();

  int _page = 0;
  void nextpage() {
    _page++;
    log("page:   $_page");
  }

  Map<String, dynamic> get _pagequerry => {"page": _page, "per_page": 20};

  ///request page from api [Api]
  Future<Map<String, dynamic>> get photospage =>
      _api.get(ApiEndpoint.curatedPhotos, queryParameters: _pagequerry);
}
