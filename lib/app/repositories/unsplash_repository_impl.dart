import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_unsplash/app/models/erros.dart';
import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';
import 'package:flutter_unsplash/app/repositories/unsplash_repository_interface.dart';

class UnsplashRepositoryImpl implements UnsplashRepositoryInterface {
  final Dio _dio;
  final unsplashAcessKey = dotenv.env['UNSPLASH_ACCESS_KEY'] ?? '';

  UnsplashRepositoryImpl(this._dio);

  @override
  Future<List<UnsplashImageModel>> getImages(
      {String? query, int page = 1}) async {
    try {
      final response = await _dio.get(
        query != null ? '/search/photos' : '/photos',
        queryParameters: {
          "client_id": unsplashAcessKey,
          "query": query ?? '',
          "page": page,
        },
      );

      final photos = <UnsplashImageModel>[];

      for (var result in query == null ? response.data : response.data['results']) {
        photos.add(UnsplashImageModel.fromMap(result));
      }

      return photos;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
        throw UnauthorizedFailure();
      } else {
        throw ConnectionFailure();
      }
    } catch (e) {
      throw Failure();
    }
  }
}
