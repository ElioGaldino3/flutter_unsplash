import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_unsplash/app/models/erros.dart';
import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';
import 'package:flutter_unsplash/app/models/view_state.dart';
import 'package:flutter_unsplash/app/repositories/unsplash_repository_interface.dart';
import 'package:get_it/get_it.dart';

class SearchController extends NotifierStore<Failure, ViewState> {
  final repo = GetIt.I.get<UnsplashRepositoryInterface>();
  SearchController() : super(ViewStateIdle());

  getUnsplashImages({String? query, int page = 1, bool reset = false}) async {
    try {
      if (!reset && state is ViewStateSucess) {
        final result = await repo.getImages(query: query, page: page);
        final images = <UnsplashImageModel>[];
        images.addAll((state as ViewStateSucess).state);
        images.addAll(result);
        update(ViewStateSucess<List<UnsplashImageModel>>(images));
      } else {
        final result = await repo.getImages(query: query, page: page);
        setLoading(true);
        update(ViewStateSucess(result));
      }
    } catch (e) {
      setError(e as Failure);
    } finally {
      setLoading(false);
    }
  }
}
