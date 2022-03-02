import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_unsplash/app/models/erros.dart';
import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';
import 'package:flutter_unsplash/app/models/view_state.dart';
import 'package:flutter_unsplash/app/widgets/err_widget.dart';
import 'package:flutter_unsplash/app/widgets/image_list_widget.dart';
import 'package:get_it/get_it.dart';

import '../controllers/search_controller.dart';

class SearchPage extends StatelessWidget {
  final SearchController controller = GetIt.I.get();
  String query = '';
  int page = 1;
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUnsplashImages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash Flutter Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => query = value,
                    decoration:
                        const InputDecoration(labelText: 'Search Images'),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    page = 1;
                    controller.getUnsplashImages(query: query, reset: true);
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            Expanded(
              child: ScopedBuilder<SearchController, Failure, ViewState>(
                store: controller,
                onState: (context, state) =>
                    state is ViewStateSucess<List<UnsplashImageModel>>
                        ? ImageListWidget(
                            state: state,
                            loadMore: () {
                              page++;
                              if (query.isNotEmpty) {
                                controller.getUnsplashImages(
                                  page: page,
                                  query: query,
                                );
                              } else {
                                controller.getUnsplashImages(page: page);
                              }
                            })
                        : const SizedBox(),
                onLoading: (context) =>
                    const Center(child: CircularProgressIndicator()),
                onError: (context, err) => ErrWidget(
                  err: err ?? Failure(),
                  retry: () {
                    page = 1;
                    controller.getUnsplashImages(query: query, reset: true);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
