import 'package:flutter/material.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filtered_movies_screen.dart';

class CategoriesSection extends StatefulWidget {
  @override
  _CategoriesSectionState createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  // static genre list instead of calling the api of getting the genres
  // not the best practice but used just for simplification purpose

  List<List> genres = [
    [28, "Action"],
    [12, "Adventure"],
    [16, "Animation"],
    [35, "Comedy"],
    [80, "Crime"],
    [99, "Documentary"],
    [18, "Drama"],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: Text('Categories', style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 700.0,
                    child: Wrap(
                      spacing: 8.0,
                      children: genres
                          .map((genre) => GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => FilteredMoviesScreen(
                                        genre: genre.last,
                                        genreId: genre.first,
                                      ),
                                    ),
                                  ),
                              child: Chip(
                                backgroundColor: Colors.amberAccent,
                                padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 2.0),
                                label: Text(
                                  ' ${genre.last}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
