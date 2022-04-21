import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:spotify_clone/views/home/carousel_item.dart';
import 'package:spotify_clone/views/home/titleandCarousel.dart';

import 'first_menu.dart';
import 'maintitleribbon.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

List try_l = ['Shows to try', 'Made For Elyupapa', 'Recently Played'];

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 12, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitleRibbon(),
                Menu(),
                ...List.generate(
                    try_l.length,
                    (index) => TitleandCarousel(
                        title: try_l[index],
                        carouselItem: CarouselItem(
                            title: try_l[index], sub_notes: try_l[index])))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
