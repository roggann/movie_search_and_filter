// class for the filter options includes the rating and release year of the movie and its genre
// and the page field is for pagination
class MoviesFilterOptions {
  MoviesFilterOptions({required this.page, this.rating, this.releaseYear, this.genreId});

  int? releaseYear;
  double? rating;
  int? genreId;
  final int page;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoviesFilterOptions && other.rating == rating && other.releaseYear == releaseYear && other.genreId == genreId && other.page == page;
  }

  @override
  int get hashCode => rating.hashCode ^ releaseYear.hashCode ^ genreId.hashCode ^ page.hashCode;
}
