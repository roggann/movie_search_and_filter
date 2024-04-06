
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_search_and_filter/features/movies/application/providers.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_filter_option.dart';
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
    expect(moviesListFromProvider.length,4);

    /// fetch movies with search of 'The Marvels' movie
    /// should return one movie
    var movieWithSearch = await container.read(fetchPaginatedMoviesFutureProvider(MoviesPagination(page: 1, query: 'The Marvels')).future);
    expect(movieWithSearch, marvelMovie);
  });

  test('test fetch The Marvels movie by it\'s id', () async {
    final fakeMoviesRepository = FakeMoviesRepository();
    final listener = Listener();
    final MarvelMovieId = 609681;
    final container = ProviderContainer(
      overrides: [
        ///overriding repository provider with the fake repository
        moviesRepositoryProvider.overrideWithValue(fakeMoviesRepository),
      ],
    );
    addTearDown(container.dispose);

    ///test the initial state for getMovieByIdProvider provider
    /// it should be null state then loading state after firing the provider
    container.listen(
      getMovieByIdProvider(MarvelMovieId),
      listener,
      fireImmediately: true,
    );
    verify(() => listener(null, const AsyncLoading<TMDBMovie>()));
    verifyNoMoreInteractions(listener);

    /// get marvel movie by id
    var movieFromProvider = await container.read(getMovieByIdProvider(MarvelMovieId).future);
    /// we compare two movies if they are the same
    expect(movieFromProvider, marvelMovie.first);

  });

  test('test fetch movies and filter for Action genre', () async {
    final fakeMoviesRepository = FakeMoviesRepository();
    final listener = Listener();
    final actionGenreId = 28;
    final container = ProviderContainer(
      overrides: [
        ///overriding repository provider with the fake repository
        moviesRepositoryProvider.overrideWithValue(fakeMoviesRepository),
      ],
    );
    addTearDown(container.dispose);

    ///test the initial state for fetchFilteredMoviesProvider provider
    /// it should be null state then loading state after firing the provider
    container.listen(
      fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, genreId: actionGenreId)),
      listener,
      fireImmediately: true,
    );
    verify(() => listener(null, const AsyncLoading<List<TMDBMovie>>()));
    verifyNoMoreInteractions(listener);


    /// fetch movies with filter of genre Action
    /// should return one movie which is Marvel
    var actionGenreMovie = await container.read(fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, genreId: actionGenreId)).future);
    expect(actionGenreMovie, marvelMovie);
  });

  test('test fetch movies and filter for release year 2023', () async {
    final fakeMoviesRepository = FakeMoviesRepository();
    final listener = Listener();
    final releaseYear = 2023;
    final container = ProviderContainer(
      overrides: [
        ///overriding repository provider with the fake repository
        moviesRepositoryProvider.overrideWithValue(fakeMoviesRepository),
      ],
    );
    addTearDown(container.dispose);

    ///test the initial state for fetchFilteredMoviesProvider provider
    /// it should be null state then loading state after firing the provider
    container.listen(
      fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, releaseYear: releaseYear)),
      listener,
      fireImmediately: true,
    );
    verify(() => listener(null, const AsyncLoading<List<TMDBMovie>>()));
    verifyNoMoreInteractions(listener);


    /// fetch movies with filter of releaseYear
    /// should return 2 movies according to the static data list
    var movieWithReleaseYearFilter= await container.read(fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, releaseYear: releaseYear)).future);
    expect(movieWithReleaseYearFilter.length, 2);
    expect(movieWithReleaseYearFilter,movieOfFilteringOnReleaseYearOf2023);
  });

  test('test fetch movies and filter for rating of 7', () async {
    final fakeMoviesRepository = FakeMoviesRepository();
    final listener = Listener();
    final double rate = 7;
    final container = ProviderContainer(
      overrides: [
        ///overriding repository provider with the fake repository
        moviesRepositoryProvider.overrideWithValue(fakeMoviesRepository),
      ],
    );
    addTearDown(container.dispose);

    ///test the initial state for fetchFilteredMoviesProvider provider
    /// it should be null state then loading state after firing the provider
    container.listen(
      fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, rating: rate)),
      listener,
      fireImmediately: true,
    );
    verify(() => listener(null, const AsyncLoading<List<TMDBMovie>>()));
    verifyNoMoreInteractions(listener);


    /// fetch movies with filter of rate
    /// should return one movie according to the static data list
    var movieWithRatingOfSevenAndAbove= await container.read(fetchFilteredMoviesProvider(MoviesFilterOptions(page: 1, rating: rate)).future);
    expect(movieWithRatingOfSevenAndAbove.length, 1);
    expect(movieWithRatingOfSevenAndAbove, movieOfFilteringOnRatingOfSevenAndAbove);
  });

}
