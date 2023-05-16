import 'package:flutter/material.dart';
import 'package:spotify_clone/views/library/library.dart';

List<Widget> printGridPlaylists() {
  return List.generate(
    LibraryPage.playlists.length,
    (index) => Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Icon(Icons.favorite, size: 40),
          height: 140,
          width: 170,
          //padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              /* borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),*/
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Colors.blue,
            //Colors.purple,
            Colors.white70
          ])),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(LibraryPage.playlists[index]),
        Text('Playlist . 36 songs',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    ),
  );
}

List<Widget> printPlaylists() {
  return List.generate(
      LibraryPage.playlists.length,
      (index) => ListTile(
            title: Text(LibraryPage.playlists[index]),
            subtitle: Row(children: [
              Text(
                'Playlist . 36 songs',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              )
            ]),
            leading: Container(
              child: const Icon(Icons.favorite),
              padding: EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  /* borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),*/
                  gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Colors.blue,
                //Colors.purple,
                Colors.white70
              ])),
            ),
          ));
}
