import 'package:flutter/material.dart';
import 'package:movie_search_and_filter/common_widgets/movie_poster.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    this.onPressed,
  });
  final TMDBMovie movie;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: MoviePoster.width,
                  height: MoviePoster.height,
                  child: MoviePoster(imagePath: movie.posterPath),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (movie.releaseDate != null) ...[
                  const SizedBox(height: 8),
                  Text('Released: ${movie.releaseDate}'),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
