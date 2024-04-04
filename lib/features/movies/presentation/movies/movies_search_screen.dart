import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/application/providers.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_pagination.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movie_list_tile.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movie_list_tile_shimmer.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movies_search_bar.dart';

class MoviesSearchScreen extends ConsumerWidget {
  const MoviesSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(moviesSearchTextProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB Movies'),
      ),
      body: Column(
        children: [
          const MoviesSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                // dispose all the pages previously fetched data
                ref.invalidate(fetchPaginatedMoviesFutureProvider);
                // fetch the first page again
                return ref.read(
                  fetchPaginatedMoviesFutureProvider(
                    MoviesPagination(page: 1, query: query),
                  ).future,
                );
              },
              child: ListView.custom(
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  final moviesList = ref.watch(
                    fetchPaginatedMoviesFutureProvider(
                        MoviesPagination(page: page, query: query)),
                  );
                  return moviesList.when(
                    error: (err, stack) => Text('Error $err'),
                    loading: () => const MovieListTileShimmer(),
                    data: (movies) {
                      // if user scrolls and reaches the end of the fetched data
                      if (indexInPage >= movies.length) {
                        return const MovieListTileShimmer();
                      }
                      final movie = movies[indexInPage];
                      return MovieListTile(
                        movie: movie,
                        onPressed: () => Navigator.of(context).pop(),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
