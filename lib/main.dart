import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies/movies_search_screen.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filtered_movies_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MoviesSearchScreen(),
      routes: {
        MoviesSearchScreen.routeName: (context) => const MoviesSearchScreen(),
        MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(movieId: 0, movie: null,),
        FilteredMoviesScreen.routeName: (context) => FilteredMoviesScreen(),
      },
    );
  }
}
