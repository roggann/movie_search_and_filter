import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_poster.dart';
import 'package:shimmer/shimmer.dart';

// widget to preview the image of the movie poster

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, this.imagePath});
  final String? imagePath;

  static const width = 154.0;
  static const height = 231.0;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return CachedNetworkImage(
        imageUrl: TMDBPoster.imageUrl(imagePath!, PosterSize.w154),
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
      );
    }
    return const Placeholder(
      color: Colors.black87,
    );
  }
}
