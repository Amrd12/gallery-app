import '../../constans/strings.dart';
import 'network.dart';

class Curatedphotosapi extends Api {
  int _page = 0;
  void nextpage() {
    _page++;
    print("page:   $_page");
  }

  Map<String, dynamic> get _pagequerry => {"page": _page};

  Future<Map<String, dynamic>> get photospage =>
      get(CuratedPhotos, queryParameters: _pagequerry);
}