import 'package:flutter/material.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filter_chip_widget.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filtered_movies_screen.dart';

class ReleaseYearSection extends StatefulWidget {
  @override
  _ReleaseYearSectionState createState() => _ReleaseYearSectionState();
}

class _ReleaseYearSectionState extends State<ReleaseYearSection> {
  // static release year instead of user entering the desired year
  // not the best practice but used just for simplification purpose
  List<int> releaseYears = [2002, 2003, 2004, 2023, 2024];

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
          child: Text('Release Years', style: Theme.of(context).textTheme.titleMedium),
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
                      children: releaseYears
                          .map((releaseYear) => FilterChipWidget(
                                filterChipAction: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FilteredMoviesScreen(
                                      releaseYear: releaseYear,
                                    ),
                                  ),
                                ),
                                filterChipTitle: '${releaseYear}',
                              ))
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
