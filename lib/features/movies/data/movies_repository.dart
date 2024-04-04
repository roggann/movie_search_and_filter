import 'dart:async';

import 'package:dio/dio.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movies_response.dart';
import 'package:movie_search_and_filter/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


class MoviesRepository {
  MoviesRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;

  Future<List<TMDBMovie>> searchMovies(
      {required int page, String query = '', CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/search/movie',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '$page',
        'query': query,
      },
    ).toString();
    final response = await client.get(url, cancelToken: cancelToken);
    final movies = TMDBMoviesResponse.fromJson(response.data);
    return movies.results;
  }


  Future<List<TMDBMovie>> fetchMovies(
      {required int page, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '$page',
      },
    ).toString();
    final response = await client.get(url, cancelToken: cancelToken);
    final movies = TMDBMoviesResponse.fromJson(response.data);
    return movies.results;
  }

  /// fetch a movie by ID
  Future<TMDBMovie> movie({required int movieId, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/$movieId',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
      },
    ).toString();
    final response = await client.get(url, cancelToken: cancelToken);
    return TMDBMovie.fromJson(response.data);
  }

}

final moviesRepositoryProvider = Provider<MoviesRepository>(
      (ref) => MoviesRepository(
        client: ref.watch(dioProvider),
        apiKey: "5597045a439aa079140e25053af71ed6",
      ),
);



