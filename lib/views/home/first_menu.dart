import 'package:flutter/material.dart';
import 'package:spotify_clone/logic/api/api.dart';
import 'package:spotify_clone/views/album_radio/album_radio.dart';
import 'package:spotify_clone/views/daily_mix.dart';
import '../../Models/album.dart' as albumFile;

class Menu extends StatelessWidget {
  Menu({
    Key? key,
  }) : super(key: key);
  List albums = [];
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

  List menu_titles = [
    "Liked songs",
    "Daily Mix 2",
    "Daily Mix 1",
    "Daily Mix 3",
    "Golden Hour",
    "Phoenix (Deluxe Edition)"
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: FutureBuilder(
            future: getAlbums(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    API()
                                        .getKygoAlbum("7tcs1X9pzFvcLOPuhCstQJ");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DailyMix(),
                                        ));
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 60,
                                            width: 70,
                                            child: index != 0
                                                ? Image(
                                                    image: NetworkImage(
                                                        index < 2
                                                            ? albums[index]
                                                                .images[0]
                                                                .url
                                                            : albums[0]
                                                                .images[0]
                                                                .url),
                                                    fit: BoxFit.cover)
                                                : const Center(
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    colors: [
                                                      Colors.blue,
                                                      //Colors.purple,
                                                      Colors.white70
                                                    ]))),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          index == 0
                                              ? "Liked Songs"
                                              : "${menu_titles[5 - index]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 180,
                                  child: Row(children: [
                                    Container(
                                      height: 60,
                                      width: 70,
                                      child: Image(
                                          image: NetworkImage(index < 2
                                              ? albums[index].images[0].url
                                              : albums[0].images[0].url),
                                          fit: BoxFit.cover),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "${menu_titles[1 + index]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 12),
                                    )
                                  ]),
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 60,
                                ),
                              ],
                            ),
                          )),
                );
              } else {
                return const OrdinaryMenu();
              }
            }),
      ),
    );
  }
}

class OrdinaryMenu extends StatelessWidget {
  const OrdinaryMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          3,
          (index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        API().getKygoAlbum("7tcs1X9pzFvcLOPuhCstQJ");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyMix(),
                            ));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 180,
                      child: Row(children: [
                        Container(
                          height: 60,
                          width: 70,
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  colors: [
                                    Colors.blue,
                                    //Colors.purple,
                                    Colors.white70
                                  ])),
                        )
                      ]),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      height: 60,
                    ),
                  ],
                ),
              )),
    );
  }
}
