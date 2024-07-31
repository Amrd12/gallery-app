import 'package:dio/dio.dart';
import 'package:gallaryapp/constans/api_key.dart';
import '../../Storage/Storage.dart';
import '../../constans/strings.dart';
import '../models/Photo_Model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Api {
  late Dio dio;
  final Storage storage = const Storage();
  Api() {
    BaseOptions options = BaseOptions(
      headers: {
        'Authorization': ApiKey,
      },
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      followRedirects: false,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response res = await dio.get(url, queryParameters: queryParameters);
      print(res.statusCode);
      // print(res.data.toString());
      return res.data;
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  saveimg(PhotoModel photo, {void Function(int, int)? onreceve}) async {
    final url = photo.src["original"];
    final dic = storage.getBaseDirectory();
    if (!storage.isdownloaded(photo.id.toString())) {
      await dio
          .download(url!, "$dic/${photo.id}.jpg", onReceiveProgress: onreceve)
          .then((_) {
        final box = Hive.box<PhotoModel>(hivebox);
        if (!photo.isInBox) box.add(photo);
        photo.isdownloaded = true;
        if (!storage.isSaved(photo.id)) photo.save();
      });
    }
  }
}
