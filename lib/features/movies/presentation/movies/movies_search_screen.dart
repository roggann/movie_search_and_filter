import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/application/providers.dart';
import 'package:movie_search_and_filter/features/movies/domain/movies_pagination.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movie_search_and_filter/features/movies/presentation/common_widgets/movie_list_tile.dart';
import 'package:movie_search_and_filter/features/movies/presentation/common_widgets/movie_list_tile_shimmer.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movies_search_bar.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/categories_section.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/rate_filter_section.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/release_year_section.dart';

class MoviesSearchScreen extends ConsumerWidget {
  static const String routeName = 'MoviesSearchScreen';

  const MoviesSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(moviesSearchTextProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('TMDB Movies'),
      ),
      body: Column(
        children: [
          const MoviesSearchBar(),
          CategoriesSection(),
          ReleaseYearSection(),
          RateFilterSection(),
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
                  // triggering and watching the provider to fetch the list of movies
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
                        // go to movie details screen and pass the movie with it's id
                        onPressed: () =>  Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(movieId: movie.id, movie: movie,),
                          ),
                        ),
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
