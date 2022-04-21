import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spotify_clone/logic/api/api.dart';
import 'package:spotify_clone/views/home/carousel_item.dart';

import '../../Models/album.dart' as albumFile;

Random i = Random();

class TitleandCarousel extends StatelessWidget {
  final String title;
  final CarouselItem carouselItem;
  TitleandCarousel({
    Key? key,
    required this.title,
    required this.carouselItem,
  }) : super(key: key);
  List<albumFile.Album> albums = [];
  Future getAlbums() async {
    try {
      albumFile.Album kygo = await API().getKygoAlbum("7tcs1X9pzFvcLOPuhCstQJ");
      albums.add(kygo);
    } on Exception catch (e) {
      rethrow;
    }
    try {
      albumFile.Album rita_ora =
          await API().getKygoAlbum("6Vn8F3hERVHYYz5RfKmsAN");
      albums.add(rita_ora);
    } catch (e) {
      rethrow;
    }
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ),
          SizedBox(
              height: 230,
              child: title == "Recently Played"
                  ? FutureBuilder(
                      future: getAlbums(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("albums: $albums");
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: albums.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                height: 180,
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      height: 150,
                                      width: 200,
                                      child: Image(
                                          image: NetworkImage(
                                              albums[index].images[0].url),
                                          fit: BoxFit.cover),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    Text(
                                      albums[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(albums[index].artists[0].name,
                                        style:
                                            TextStyle(color: Colors.grey[600]))
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          print("No Data");
                          return OrdinaryCarouel(
                              title: title, carouselItem: carouselItem);
                        }
                      })
                  : OrdinaryCarouel(title: title, carouselItem: carouselItem)),
        ],
      ),
    );
  }
}

class OrdinaryCarouel extends StatelessWidget {
  const OrdinaryCarouel({
    Key? key,
    required this.title,
    required this.carouselItem,
  }) : super(key: key);

  final String title;
  final CarouselItem carouselItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: title == "Recently Played" ? 2 : 8,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 180,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
              ),
              Text(
                carouselItem.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(carouselItem.sub_notes,
                  style: TextStyle(color: Colors.grey[600]))
            ],
          ),
        );
      },
    );
  }
}
