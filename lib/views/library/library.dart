import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:spotify_clone/views/library/library_app_bar.dart';
import 'package:spotify_clone/views/library/print_artists.dart';
import 'package:spotify_clone/views/library/print_playlists.dart';

import 'library_tabbar.dart';
import 'options_ribbon.dart';

class LibraryPage extends StatefulWidget {
  static bool gridView = false;
  static List artists = [
    'Starley',
    'Jonas Blue',
    'Kygo',
    'Avicii',
    'Justin Beiber',
    'Niall Horan',
    'Ed Sheeran'
  ];
  static List playlists = [
    'Liked Songs',
    'Before U',
    'Happy mood music',
    'Upbeat Pop Hits 2021'
  ];
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List tabs = ['Playlists', 'Artists', 'Albums', 'Downloaded'];

  @override
  Widget build(BuildContext context) {
    print('grid: ${LibraryPage.gridView}');
    return CustomScrollView(
        //appBar: libraryAppBar(),
        slivers: [
          libraryPageSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: OptionsRibbon(
                sort: () {
                  setState(() {
                    LibraryPage.gridView == true
                        ? LibraryPage.gridView = false
                        : LibraryPage.gridView = true;
                  });
                  print("kuku: ${LibraryPage.gridView}");
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: LibraryPage.gridView
                ? SliverGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 40,
                    children: [
                      ...printGridPlaylists(),
                      ...printGridArtists()

                      //addArtists(),
                      //addPodcasts()
                    ],
                  )
                : SliverList(
                    delegate: SliverChildListDelegate([
                      ...printPlaylists(),
                      ...printArtists(),
                      addArtists(),
                      addPodcasts()
                    ]),
                  ),
          ),
        ]);
  }

  SliverAppBar libraryPageSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 130,
      collapsedHeight: 80,
      pinned: true,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: TabBar(
              isScrollable: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              indicator: BoxDecoration(color: Colors.transparent),
              controller: _tabController,
              tabs: [
                ...List.generate(
                    tabs.length,
                    (index) => Container(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          // ignore: prefer_const_constructors
                          child: Text(tabs[index],
                              style: TextStyle(
                                  //fontSize: 25,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black,
                              border: Border.all(color: Colors.grey.shade600)),
                        ))
              ]),
        ),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      actions: const [Icon(Icons.search), SizedBox(width: 10), Icon(Icons.add)],
      title: const Text('Your Library',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
      leading: Container(
        //padding: const EdgeInsets.all(value),
        //height: 10,
        //width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(70),
            color: Colors.purple.shade700),
        child: Center(
          child: const Text(
            'E',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }

  ListTile addPodcasts() {
    return ListTile(
        leading: Container(
          child: Icon(
            Icons.add,
            color: Colors.grey[400],
          ),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              /* borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),*/
              color: Colors.grey.shade700),
        ),
        title: Text('Add podcasts & shows'),
        subtitle: Text(
          'Artist',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ));
  }
}

class addArtists extends StatelessWidget {
  const addArtists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.add),
          backgroundColor: Colors.grey.shade600,
        ),
        title: Text('Add artists'),
        subtitle: Text(
          'Artist',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ));
  }
}
