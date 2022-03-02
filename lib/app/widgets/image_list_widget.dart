import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';
import 'package:flutter_unsplash/app/models/view_state.dart';
import 'package:flutter_unsplash/app/pages/image_page.dart';

class ImageListWidget extends HookWidget {
  final ViewStateSucess<List<UnsplashImageModel>> state;
  final VoidCallback loadMore;

  const ImageListWidget({
    Key? key,
    required this.state,
    required this.loadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ScrollController _scrollController;
    useEffect(() {
      _scrollController = ScrollController();

      _scrollController.addListener(() {
        final diff = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (diff < 300) {
          loadMore();
          debugPrint('Chamando mais $diff');
        }
      });

      return () => _scrollController.dispose();
    });

    return MasonryGridView.count(
      controller: _scrollController,
      itemCount: state.state.length,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      itemBuilder: (context, index) {
        final image = state.state[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImagePage(image: image)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ExtendedImage.network(
                  image.urls.regular,
                  cache: true,
                  fit: BoxFit.cover,
                ),
                Container(
                    width: double.infinity, height: 30, color: Colors.black),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    image.user.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
