import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/application/providers.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_filter_option.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movie_list_tile.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movie_list_tile_shimmer.dart';

class FilteredMoviesScreen extends ConsumerWidget {
  static const String routeName = 'FilteredMoviesScreen';
  final int? releaseYear;
  final double? rating;
  final String? genre;
  final int? genreId;
  FilteredMoviesScreen({ this.rating, this.releaseYear, this.genre,this.genreId,super.key});
  static const pageSize = 20;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rating==null? (releaseYear==null?'Popular in ${genre}':'Released in $releaseYear'):'Movies with rating of ${rating}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                // dispose all the pages previously fetched data
                ref.invalidate(fetchPaginatedMoviesFutureProvider);
                // fetch the first page again
                return ref.read(
                  fetchFilteredMoviesProvider(
                    MoviesFilterOptions(page: 1, genreId: genreId,rating: rating,releaseYear: releaseYear),
                  ).future,
                );
              },
              child: ListView.custom(
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  final moviesList = ref.watch(
                    fetchFilteredMoviesProvider(
                        MoviesFilterOptions(page: page, genreId: genreId,rating: rating,releaseYear: releaseYear)),
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
