import 'package:dio/dio.dart';
import 'package:flutter_unsplash/app/controllers/search_controller.dart';
import 'package:flutter_unsplash/app/repositories/unsplash_repository_impl.dart';
import 'package:flutter_unsplash/app/repositories/unsplash_repository_interface.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
      .registerSingleton(Dio(BaseOptions(baseUrl: 'https://api.unsplash.com')));
  getIt.registerSingleton<UnsplashRepositoryInterface>(
    UnsplashRepositoryImpl(getIt.get()),
  );
  getIt.registerSingleton(SearchController());
}
