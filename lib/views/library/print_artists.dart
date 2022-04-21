import 'package:flutter/material.dart';
import 'package:spotify_clone/views/library/library.dart';

List<Widget> printArtists() {
  return List.generate(
      LibraryPage.artists.length,
      (index) => ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.orangeAccent,
          ),
          title: Text(LibraryPage.artists[index]),
          subtitle: Text(
            'Artist',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          )));
}

List<Widget> printGridArtists() {
  return List.generate(
    LibraryPage.artists.length,
    (index) => Column(
      children: [
        Container(
          child: const Icon(Icons.favorite, size: 40),
          height: 140,
          width: 170,
          //padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
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
        Text(LibraryPage.artists[index]),
        Text('Artist',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    ),
  );
}
