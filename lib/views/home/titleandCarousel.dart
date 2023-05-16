import 'dart:math';

import 'package:flutter/material.dart';

import 'package:spotify_clone/Models/sho.dart';
import 'package:spotify_clone/logic/api/api.dart';
import 'package:spotify_clone/views/home/carousel_item.dart';

import '../../Models/album.dart' as albumFile;
import '../daily_mix.dart';

Random i = Random();

class TitleandCarousel extends StatelessWidget {
  final String title;
  final CarouselItem carouselItem;
  TitleandCarousel({
    Key? key,
    required this.title,
    required this.carouselItem,
  }) : super(key: key);
  List albums = [];
  Future getAlbums() async {
    try {
      albumFile.Album kygo = await API().getAlbum("7tcs1X9pzFvcLOPuhCstQJ");
      albums.add(kygo);
    } on Exception catch (e) {
      rethrow;
    }
    try {
      albumFile.Album rita_ora = await API().getAlbum("6Vn8F3hERVHYYz5RfKmsAN");
      albums.add(rita_ora);
    } catch (e) {
      rethrow;
    }
    return albums;
  }

  Future getshows(String ids) async {
    try {
      List shows = await API().getShows(ids);
      print("have the Shows to try");
      return shows;
    } on Exception catch (e) {
      print("error $e");
      rethrow;
    }
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
          SizedBox(height: 230, child: carousel(title)) //carousel(title)),
        ],
      ),
    );
  }

  FutureBuilder<dynamic> yourShows() {
    String show_ids = "5vuQ05sncjn5AgfxmuN4i5,1VXcH8QHkjRcTCEd88U3ti";
    return FutureBuilder(
        future: getshows(show_ids),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("albums: $albums");
            List<Show> shows = snapshot.data as List<Show>;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shows.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyMix(
                            album: sho[index],
                          ),
                        ));*/
                  },
                  child: Container(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                                image:
                                    NetworkImage(shows[index].images![0].url),
                                fit: BoxFit.cover),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Text(
                          shows[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text("Show • ${shows[index].publisher}",
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            print("Error occured couldn't load shows");
            return OrdinaryCarousel(title: title, carouselItem: carouselItem);
          } else {
            print("No Data");
            return OrdinaryCarousel(title: title, carouselItem: carouselItem);
          }
        });
  }

  FutureBuilder<dynamic> recentlyPlayed() {
    return FutureBuilder(
        future: API().getAlbums(
            "1atjqOZTCdrjxjMyCPZc2g,6trNtQUgC8cgbWcqoMYkOR,6Vn8F3hERVHYYz5RfKmsAN,7tcs1X9pzFvcLOPuhCstQJ,6M4Nu5UgX097dxeF2lm9P8"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            albums = snapshot.data as List;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyMix(
                            album: albums[index],
                          ),
                        ));
                  },
                  child: Container(
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
                          child: Image(
                              image: NetworkImage(albums[index].images![0].url),
                              fit: BoxFit.cover),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Text(
                          albums[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(albums[index].artists![0].name,
                            style: TextStyle(color: Colors.grey[600]))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            print("No Data");
            return OrdinaryCarousel(title: title, carouselItem: carouselItem);
          }
        });
  }

  FutureBuilder<dynamic> madeForElyuPapa() {
    String album_ids =
        "1atjqOZTCdrjxjMyCPZc2g,6trNtQUgC8cgbWcqoMYkOR,6M4Nu5UgX097dxeF2lm9P8";
    return FutureBuilder(
        future: API().getAlbums(album_ids),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List albumsmadeForElyu = snapshot.data;
            print("albumsmadeForElyu: $albumsmadeForElyu");
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albumsmadeForElyu.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyMix(
                            album: albumsmadeForElyu[index],
                          ),
                        ));
                  },
                  child: Container(
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
                          child: Image(
                              image: NetworkImage(
                                  albumsmadeForElyu[index].images[0].url),
                              fit: BoxFit.cover),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Text(
                          albumsmadeForElyu[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(albumsmadeForElyu[index].artists[0].name,
                            style: TextStyle(color: Colors.grey[600]))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            print("No Data in elyu");
            return OrdinaryCarousel(title: title, carouselItem: carouselItem);
          }
        });
  }

  carousel(String title) {
    switch (title) {
      case "Shows to try":
        return yourShows();
      case "Made For Papa":
        print("Made For Papa");
        return madeForElyuPapa();
      case "Recently Played":
        return recentlyPlayed();
      default:
        OrdinaryCarousel(title: title, carouselItem: carouselItem);
    }
  }
}

class OrdinaryCarousel extends StatelessWidget {
  const OrdinaryCarousel({
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
