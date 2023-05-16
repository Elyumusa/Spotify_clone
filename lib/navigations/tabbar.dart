import 'package:flutter/material.dart';
import 'package:spotify_clone/views/library/library.dart';

import '../views/home/home.dart';
import '../views/Search/search.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          renderPage(currentTab, 0, HomeView()),
          renderPage(currentTab, 1, SearchPage()),
          renderPage(currentTab, 2, LibraryPage())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                ),
                label: "Your Library"),
          ]),
    );
  }
}

Widget renderPage(int currentTab, int pageIndex, Widget child) {
  return IgnorePointer(
    ignoring: currentTab != pageIndex,
    child: Opacity(opacity: currentTab != pageIndex ? 0 : 1, child: child),
  );
}
