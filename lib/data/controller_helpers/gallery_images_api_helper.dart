import 'dart:io';
import 'package:dio/dio.dart';
import 'package:task/data/abstract/api_helper.dart';

class GalleryImagesApiHelper {
  GalleryImagesApiHelper._();
  static Dio? _instance;
  static Dio get instance {
    _instance ??= ApiHelper.instance;
    return _instance!;
  }

  static Future<Response> getImages() async {
    try {
      return await instance.get(
        'my-gallery',
      );
    } on DioError catch (exception) {
      return exception.response!;
    }
  }

  static Future<Response> uploadImage(File image) async {
    try {
      return await instance.post('upload',
          data: FormData.fromMap(
              {'img': await MultipartFile.fromFile(image.path)}));
    } on DioError catch (exception) {
      return exception.response!;
    }
  }
}
