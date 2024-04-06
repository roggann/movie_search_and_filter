import 'package:flutter/material.dart';


class FilterChipWidget extends StatelessWidget {
  final Function filterChipAction;
  final String filterChipTitle;

  const FilterChipWidget({
    required this.filterChipAction,
    required this.filterChipTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => filterChipAction(),
        child: Chip(
          backgroundColor: Colors.amberAccent,
          padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 2.0),
          label: Text(
            filterChipTitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
