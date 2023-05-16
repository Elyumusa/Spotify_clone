import 'package:flutter/material.dart';
import 'package:spotify_clone/views/Search/print_title.dart';
import 'package:spotify_clone/views/library/library.dart';
import 'package:spotify_clone/views/library/showSortByBottomsheet.dart';

class OptionsRibbon extends StatefulWidget {
  void Function() sort;
  OptionsRibbon({
    required this.sort,
    Key? key,
  }) : super(key: key);

  @override
  State<OptionsRibbon> createState() => _OptionsRibbonState();
}

class _OptionsRibbonState extends State<OptionsRibbon> {
  String sortBy = "Most Recent";
  List sortingOptions = [
    'Most Recent',
    "Recently Played",
    "Recently Added",
    "Alphabetical",
    "Creator"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          InkResponse(
            onTap: () => showSortByBottomsheet(
              context,
              sortingOptions,
              sortBy,
              (index) {
                setState(() {
                  sortBy = sortingOptions[index];
                });
                Navigator.pop(context);
              },
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_upward),
                SizedBox(width: 10),
                Text(sortBy),
              ],
            ),
          ),
          const Spacer(),
          InkResponse(
              onTap: () {
                widget.sort();
              },
              child: const Icon(Icons.sort))
        ],
      ),
    );
  }
}
