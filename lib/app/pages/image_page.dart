import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash/app/models/unsplash_image_model.dart';

class ImagePage extends StatelessWidget {
  final UnsplashImageModel image;

  const ImagePage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image.user.name),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: image.id,
          child: ExtendedImage.network(
            image.urls.regular,
            fit: BoxFit.cover,
            cache: true,
          ),
        ),
      ),
    );
  }
}
