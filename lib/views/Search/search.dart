import 'package:flutter/material.dart';
import 'package:spotify_clone/views/Search/print_title.dart';
import 'package:spotify_clone/views/Search/your_top_genre_menu.dart';

import 'browse_all.dart';
import 'search_menu.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

//TODO: create genre model
List browsealllist = [
  "Podcasts",
  "Made for you",
  "Charts",
  "New Releases",
  "Discover",
  "Concerts",
  "League of Legends",
  "Podcasts",
  "Made for you",
  "Charts",
  "New Releases",
  "Discover",
  "Concerts",
  "League of Legends"
];

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          searchMenu(context),
          printTitle("Your top genres"),
          yourTopGenresMenu(),
          printTitle("Browse all"),
          browseall(browsealllist)
        ],
      ),
    );
  }
}
