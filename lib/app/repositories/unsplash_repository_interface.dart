import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';

abstract class UnsplashRepositoryInterface {
  Future<List<UnsplashImageModel>> getImages({String? query, int page = 1});
}
