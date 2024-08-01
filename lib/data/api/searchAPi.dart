import '../../constans/strings.dart';
import 'network.dart';

class searchapi extends Api {
  int _page = 0;
  void nextpage() => _page++;
  String _query = "", _type = "";
  Map<String, dynamic> get _pagequerry =>
      {"page": _page, "query": _query, "orientation": _type};

  Future<Map<String, dynamic>> getSearch(String query, String type) async {
    _query = query;
    if (type != "") _type = type;
    final data = await get(Search, queryParameters: _pagequerry);
    return data;
  }
}
