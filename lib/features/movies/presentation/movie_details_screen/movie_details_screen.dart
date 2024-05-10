import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/presentation/state/providers.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';
import 'package:movie_search_and_filter/features/movies/presentation/common_widgets/movie_list_tile.dart';
import 'package:movie_search_and_filter/features/movies/presentation/common_widgets/movie_list_tile_shimmer.dart';

// screen to show movie detail

class MovieDetailsScreen extends ConsumerWidget {
  static const String routeName = 'MovieDetailsScreen';

  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movie});
  final int movieId;
  final TMDBMovie? movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (movie != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(movie!.title),
        ),
        body: Column(
          children: [
            MovieListTile(movie: movie!),
          ],
        ),
      );
    } else {
      // watching the provider of getting the movie by id
      final movieAsync = ref.watch(getMovieByIdProvider( movieId));
      return movieAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(movie?.title ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(movie?.title ?? 'Loading'),
          ),
          body: const Column(
            children: [
              MovieListTileShimmer(),
            ],
          ),
        ),
        data: (movie) => Scaffold(
          appBar: AppBar(
            title: Text(movie.title),
          ),
          body: Column(
            children: [
              MovieListTile(movie: movie),
            ],
          ),
        ),
      );
    }
  }
}
