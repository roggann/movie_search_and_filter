import 'package:flutter/material.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filter_chip_widget.dart';
import 'package:movie_search_and_filter/features/movies/presentation/movies_filteration/filtered_movies_screen.dart';

class RateFilterSection extends StatefulWidget {
  @override
  _RateFilterSectionState createState() => _RateFilterSectionState();
}

class _RateFilterSectionState extends State<RateFilterSection> {
  // static rates instead of user entering the desired rating
  // not the best practice but used just for simplification purpose
  List<double> rates = [
    5,
    5.5,
    6,
    6.5,
    7,
    8,
    8.9,
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
          child: Text('Ratings', style: Theme.of(context).textTheme.titleMedium),
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
                      children: rates
                          .map((rate) => FilterChipWidget(
                                filterChipAction: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FilteredMoviesScreen(
                                      rating: rate,
                                    ),
                                  ),
                                ),
                                filterChipTitle: '${rate} stars',
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
