import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../services/Storage/Storage.dart';
import '../../constans/api_key.dart';
import '../../constans/strings.dart';
import '../models/photo_model.dart';

class Api {
  late Dio dio;
  final Storage storage = const Storage();
  Api() {
    BaseOptions options = BaseOptions(
      headers: {
        'Authorization': apiKey,
      },
      baseUrl: ApiEndpoint.baseUrl,
      receiveDataWhenStatusError: true,
      followRedirects: false,
    );
    dio = Dio(options);
  }

  /// TO Request url from Api
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response res = await dio.get(url, queryParameters: queryParameters);
      log("states code: ${res.statusCode}");
      // print(res.data.toString());
      return res.data;
    } catch (e) {
      log('Error occurred: $e');
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
        final box = Hive.box<PhotoModel>(HiveBoxNames.hiveBox);

        if (!storage.isSaved(photo.id)) {
          if (!photo.isInBox) box.add(photo);
        }
        photo.isdownloaded = true;
        photo.save();
      });
    }
  }
}
