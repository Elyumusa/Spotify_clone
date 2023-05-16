import 'package:flutter/material.dart';
import 'package:spotify_clone/Models/album.dart' as albumFile;
import 'package:spotify_clone/logic/api/api.dart';

import '../widgets/category_tabBar.dart';

class SearchD extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
      IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showResults(context);
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Stack(children: [
      FutureBuilder(
        future: API().search(query), // as Future<List<albumFile.Track>>,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<albumFile.Track> tracks =
                snapshot.data as List<albumFile.Track>;
            return ListView(
              children: [
                CategoryPicker(tabItems: [
                  'Top',
                  'Songs',
                  'Artists',
                  'Playlists',
                  'Albums'
                ], whenTabChanges: () {}, usedInMyOrders: true),
                SizedBox(
                  height: 8,
                ),
                ...List.generate(
                  tracks.length,
                  (index) {
                    return ListTile(
                      trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {}),
                      leading: Image(
                          image: NetworkImage(tracks[index].images![0].url),
                          fit: BoxFit.cover),
                      title: Text("${tracks[index].name}"),
                      subtitle: Text(
                        "Song-${tracks[index].artists![0].name}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return ListView();
          }
        },
      ),
    ]);
  }
}
