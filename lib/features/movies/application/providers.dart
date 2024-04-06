import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_filter_option.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_pagination.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_repository.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';
import 'package:movie_search_and_filter/utils/exceptions.dart';

// family future provider for searching for a movie by movie title "query" if not null or get list of movies without search
final fetchPaginatedMoviesFutureProvider = AutoDisposeFutureProviderFamily<List<TMDBMovie>, MoviesPagination>((ref, moviesPagination) async {
  final moviesRepo = ref.watch(moviesRepositoryProvider);
// Cancel the page request if the UI no longer needs it
// This happens if the user scrolls very fast or if we type a different search
// term.
  final cancelToken = CancelToken();
// When a page is no-longer used we keep it in the cache.
  final link = ref.keepAlive();
// a timer to be used by the callbacks below
  Timer? timer;
// When the provider is destroyed we cancel the http request and the timer
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
// When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
// start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
// dispose on timeout
      link.close();
    });
  });
// if the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  if (moviesPagination.query.isEmpty) {
// use non-search endpoint
    return moviesRepo.fetchMovies(
      page: moviesPagination.page,
      cancelToken: cancelToken,
    );
  } else {
// Debounce the request by having this delay consumers can subscribe to
// different parameters in which case this request will be aborted.
    await Future.delayed(const Duration(milliseconds: 500));
    if (cancelToken.isCancelled) throw AbortedException();
// use search endpoint
    return moviesRepo.searchMovies(
      page: moviesPagination.page,
      query: moviesPagination.query,
      cancelToken: cancelToken,
    );
  }
});

// family future provider for getting a movie details by id
final getMovieByIdProvider = FutureProviderFamily<TMDBMovie, int>((ref, id) {
  // call the endpoint for getting movie by its id
  return ref.watch(moviesRepositoryProvider).movie(movieId: id);
});

// family future provider for getting a movies list with filters options
// releaseYear rating genre
final fetchFilteredMoviesProvider = AutoDisposeFutureProviderFamily<List<TMDBMovie>, MoviesFilterOptions>((ref, moviesFilterOptions) async {
  final moviesRepo = ref.watch(moviesRepositoryProvider);

  if (moviesFilterOptions.genreId != null) {
    // call the endpoint with specified genre
    return moviesRepo.filterMovies(page: moviesFilterOptions.page, genreId: moviesFilterOptions.genreId);
  } else if (moviesFilterOptions.releaseYear != null) {
    // call the endpoint with the specified release year
    return moviesRepo.filterMovies(page: moviesFilterOptions.page, releaseYear: moviesFilterOptions.releaseYear);
  } else if (moviesFilterOptions.rating != null) {
    // call the endpoint with the specified rating
    return moviesRepo.filterMovies(page: moviesFilterOptions.page, rating: moviesFilterOptions.rating);
  }
  return [];
});
