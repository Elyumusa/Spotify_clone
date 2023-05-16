import 'package:flutter/material.dart';
import 'package:spotify_clone/logic/api/api.dart';
import 'package:spotify_clone/views/album_radio/album_radio.dart';
import 'package:spotify_clone/views/daily_mix.dart';
import '../../Models/album.dart' as albumFile;

class Menu extends StatefulWidget {
  Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List albums = ["Liked songs"];

  Future getAlbums() async {
    List a_s = [];
    try {
      a_s = await API().getAlbums(
          "1atjqOZTCdrjxjMyCPZc2g,6trNtQUgC8cgbWcqoMYkOR,7tcs1X9pzFvcLOPuhCstQJ,6Vn8F3hERVHYYz5RfKmsAN,6M4Nu5UgX097dxeF2lm9P8");

      return a_s;
    } on Exception catch (e) {
      print("error $e");
      rethrow;
    }
  }

  late Future albums_future;
  List menu_titles = [
    "Liked songs",
    "Daily Mix 2",
    "Daily Mix 1",
    "Daily Mix 3",
    "Golden Hour",
    "Ty Dolla \$ign"
  ];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    albums_future = getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    int counter = 1;
    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: FutureBuilder(
            future: albums_future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                albums = snapshot.data as List;
                /*for (var item in snapshot.data as List) {
                  albums.add(item);
                }*/
                print(
                    " In print 0: ${albums[0].name}, Counter +1: ${albums[1].name}, counter: $counter");
                print(
                    " In print 2: ${albums[2].name}, Counter +1: ${albums[3].name}, counter: $counter");
                print(
                    " In print 4: ${albums[4].name}, Counter +1: ${albums[4].name}, counter: $counter");
                print("Album length: ${albums.length}");
                return Column(children: [
                  indiviualRow(0, context),
                  indiviualRow(1, context),
                  indiviualRow(3, context),
                ]); /*List.generate(3, (index) {
                    counter += index;
                    print(
                        "Counter: $counter, In has data ${albums[counter].name}");
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(
                                  " In print: ${albums[counter].name}, Counter +1: ${counter + 1}, counter: $counter");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DailyMix(
                                      album: albums[counter],
                                    ),
                                  ));
                            },
                            child: menuItem(
                                index != 0
                                    ? Image(
                                        image: NetworkImage(
                                            albums[counter].images[0].url),
                                        fit: BoxFit.cover)
                                    : const Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      ),
                                index == 0
                                    ? "Liked Songs"
                                    : "${albums[counter].name}",
                                context),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              print(
                                  " In print t: ${albums[counter + 1].name}, Counter +1: ${counter + 1}, counter: $counter,len:${albums.length}");
                              int ind = 0;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DailyMix(
                                      album: albums[counter + 1],
                                    ),
                                  ));
                            },
                            child: menuItem(
                                Image(
                                    image: NetworkImage(index == 0
                                        ? albums[counter].images[0].url
                                        : albums[counter + 1].images[0].url),
                                    fit: BoxFit.cover),
                                index == 0
                                    ? "${albums[counter].name}"
                                    : "${albums[counter + 1].name}",
                                context),
                          )
                        ],
                      ),
                    );
                  }),
                );*/
              } else {
                print("not in has data");
                return const OrdinaryMenu();
              }
            }),
      ),
    );
  }

  Padding indiviualRow(int counter, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyMix(
                      album: albums[counter],
                    ),
                  ));
            },
            child: menuItem(
                counter != 0
                    ? Image(
                        image: NetworkImage(albums[counter].images[0].url),
                        fit: BoxFit.cover)
                    : const Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                counter == 0 ? "Liked Songs" : "${albums[counter].name}",
                context),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              int ind = 0;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyMix(
                      album:
                          counter == 0 ? albums[counter] : albums[counter + 1],
                    ),
                  ));
            },
            child: menuItem(
                Image(
                    image: NetworkImage(counter == 0
                        ? albums[counter].images[0].url
                        : albums[counter + 1].images[0].url),
                    fit: BoxFit.cover),
                counter == 0
                    ? "${albums[counter].name}"
                    : "${albums[counter + 1].name}",
                context),
          )
        ],
      ),
    );
  }

  Container menuItem(Widget child, String text, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 180,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 48, 47, 47),
          borderRadius: BorderRadius.circular(8)),
      height: 50,
      child: Row(
        children: [
          Container(
              height: 50,
              width: 70,
              child: child,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                    Colors.blue,
                    //Colors.purple,
                    Colors.white70
                  ]))),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 11, overflow: TextOverflow.clip),
            ),
          )
        ],
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
                        API().getAlbum("7tcs1X9pzFvcLOPuhCstQJ");
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyMix(),
                            ));*/
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
