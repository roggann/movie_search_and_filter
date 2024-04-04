
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_search_and_filter/features/movies/application/providers.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_pagination.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_repository.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';

import '../../../../listener.dart';
import '../data/fake_movies_repository.dart';

void main() {
  setUpAll(() async {
    registerFallbackValue(AsyncValue<List<TMDBMovie>>);
  });

  test('test fetch movies and search for The Marvels movie', () async {
    final fakeMoviesRepository = FakeMoviesRepository();
    final listener = Listener();
    final container = ProviderContainer(
      overrides: [
        ///overriding repository provider with the fake repository
        moviesRepositoryProvider.overrideWithValue(fakeMoviesRepository),
        ],
    );
    addTearDown(container.dispose);

    ///test the initial state for fetchPaginatedMoviesFutureProvider provider
    /// it should be null state then loading state after firing the provider
    container.listen(
      fetchPaginatedMoviesFutureProvider(MoviesPagination(page: 1, query: '')),
      listener,
      fireImmediately: true,
    );
    verify(() => listener(null, const AsyncLoading<List<TMDBMovie>>()));
    verifyNoMoreInteractions(listener);

    /// fetch movies without search
    /// should return the movies list
    var moviesListFromProvider = await container.read(fetchPaginatedMoviesFutureProvider(MoviesPagination(page: 1, query: '')).future);
    /// we compare two lists using expect function
    expect(moviesListFromProvider, movies);
    expect(moviesListFromProvider.length,3);

    /// fetch movies with search of 'The Marvels' movie
    /// should return one movie
    var movieWithSearch = await container.read(fetchPaginatedMoviesFutureProvider(MoviesPagination(page: 1, query: 'The Marvels')).future);
    expect(movieWithSearch, moviesWithSearch);
  });
}
