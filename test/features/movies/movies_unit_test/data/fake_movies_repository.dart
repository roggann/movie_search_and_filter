import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_search_and_filter/features/movies/data/movies_repository.dart';
import 'package:movie_search_and_filter/features/movies/domain/tmdb_movie.dart';

// some fake movies data
var result = {
  "results": [
    {"adult":false,"backdrop_path":"/bAvIcsFLfqX5hVmxoKFTRUbu4kk.jpg","genre_ids":[18,10751],"id":1105690,"original_language":"es","original_title":"MAR","overview":"Raymundo is constantly tormented during his vacation at the beach by a painful memory from his past that he had not wanted to face.","popularity":0.6,"poster_path":"/scSJ1y7WkHwYXHXay0s1QgjueT2.jpg","release_date":"2023-09-05","title":"MAR","video":false,"vote_average":6.2,"vote_count":2},
    {"adult":false,"backdrop_path":"/sKYwjQq3LOJ862qFHLFEoj4ySYs.jpg","genre_ids":[18],"id":599963,"original_language":"pt","original_title":"Mar","overview":"Francisca, a beautiful 50-year-old widow, prepared a peaceful future for herself. In an unexpected outburst, she grabs an opportunity for change and embarks on a sailboat called ‘Hovering Over the Water’.","popularity":1.421,"poster_path":"/kcrJ1JYEgddEl5VBi0d4PVbXcHY.jpg","release_date":"2018-09-25","title":"Sea","video":false,"vote_average":5.1,"vote_count":5},
    {"adult":false,"backdrop_path":null,"genre_ids":[18],"id":949759,"original_language":"sr","original_title":"Mar","overview":"During an epidemic, a young couple use their day off to take Mar on a day trip to canyon. Mar is girl's elder sister with ASD.  Along the way, they will try to process the emotional situation they found themselves in. As their world collapses pressed by external influences and internal crises, Mar with them exists as a separate world. Her world is clean and horrible at the same time because it is unknown...","popularity":0.6,"poster_path":"/1QVGLzi0rbYVaA2yWujpGUat0cn.jpg","release_date":"2022-02-19","title":"Mar","video":false,"vote_average":6.0,"vote_count":2},
  ]
};

// the result of searching on Marvel movie name
var resultWithSearch = {
  "results": [
    {"adult":false,"backdrop_path":"/w4pRLYYbhHn3sh9kqRgPZM6GjyS.jpg","genre_ids":[878,12,28],"id":609681,"original_language":"en","original_title":"The Marvels","overview":"Carol Danvers, aka Captain Marvel, has reclaimed her identity from the tyrannical Kree and taken revenge on the Supreme Intelligence. But unintended consequences see Carol shouldering the burden of a destabilized universe. When her duties send her to an anomalous wormhole linked to a Kree revolutionary, her powers become entangled with that of Jersey City super-fan Kamala Khan, aka Ms. Marvel, and Carol’s estranged niece, now S.A.B.E.R. astronaut Captain Monica Rambeau. Together, this unlikely trio must team up and learn to work in concert to save the universe.","popularity":304.392,"poster_path":"/9GBhzXMFjgcZ3FdR9w3bUMMTps5.jpg","release_date":"2023-11-08","title":"The Marvels","video":false,"vote_average":6.203,"vote_count":2133}  ]
};

final movies = result['results']!.map((x) => TMDBMovie.fromJson(x)).toList();
final moviesWithSearch = resultWithSearch['results']!.map((x) => TMDBMovie.fromJson(x)).toList();

// a fake repository to return desired test data
class FakeMoviesRepository extends Mock implements MoviesRepository {
  @override
  Future<List<TMDBMovie>> searchMovies({required int page, String query = '', CancelToken? cancelToken}) async {
    // if user is searching for "The Marvels" movie return that one movie
    return  moviesWithSearch;
  }
  @override
  Future<List<TMDBMovie>> fetchMovies({required int page, CancelToken? cancelToken}) async {
    // return the whole list of data
    return movies;
  }
}

