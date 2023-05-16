import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/Models/album.dart' as albumfile;
import 'package:spotify_clone/logic/api/api.dart';
import 'package:spotify_clone/logic/cubit/internet_cubit.dart';

import '../logic/cubit/internet_state.dart';

class DailyMix extends StatefulWidget {
  final albumfile.Album album;

  const DailyMix({Key? key, required this.album}) : super(key: key);
  @override
  State<DailyMix> createState() => _DailyMixState();
}

class _DailyMixState extends State<DailyMix> {
  ScrollController scrollController = ScrollController();
  double imageSize = 300;
  double containerHeight = 570;
  double initialContainerHeight = 570;
  double offset = 0;
  //albumfile.Album? kygoAlbum;
  /* void getAlbum() async {
    var response = await API().getKygoAlbum();
    print("done cutting");
    if (response != "Error occured") {
      print(" cutting");
      kygoAlbum = response;
      print("Album trackkk:${kygoAlbum?.tracks} ");
    } else {
      print("aalllll cutting");
      showDialog(
          context: context,
          builder: (conte) {
            return const AlertDialog(
              content: const Text("Error Occured"),
            );
          });
    }
  }*/

  late Future getkygoAlbum;
  late Widget noInternetConnection;
  @override
  void initState() {
    // TODO: implement initState
    //getAlbum();
    //print("Album trackkk:${kygoAlbum?.tracks} ");
    getkygoAlbum = API().getAlbum("7tcs1X9pzFvcLOPuhCstQJ");
    noInternetConnection = noInternet();
    //kygoAlbum = widget.album;
    //topB = topbar(context);

    scrollController.addListener(() {
      offset = scrollController.offset;
      //offset = -containerHeight + offset;
      print("of ${scrollController.offset}");
      print(-containerHeight + offset);
      print("containerHeight: $containerHeight");
      //setState(() {});
      imageSize = 300 - scrollController.offset;
      print("imageSize: $imageSize");
      if (imageSize < 0) {
        imageSize = 0;
      }
      containerHeight = initialContainerHeight - scrollController.offset;
      if (containerHeight < 0) {
        containerHeight = 0;
      }
      print("containerHeight: ${(-containerHeight + 30) + offset}");

      topB = topbar(context);
      setState(() {});
    });

    super.initState();
  }

  num appBarOpacity = 0;
  @override
  Widget build(BuildContext context) {
    print(" off: ${-containerHeight + offset}");
    return BlocConsumer<InternetCubit, InternetState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state == InternetState.InternetDisconnected
            ? noInternetConnection
            : Scaffold(
                body: Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 66, 66, 80),
                    ),
                    SafeArea(
                      child: SingleChildScrollView(
                        //physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: [mixTheme(context), mixSongs(context)],
                        ),
                      ),
                    ),
                    appBarAndPlayButton(context)
                  ],
                ),
              );

        //return daily_mi(state);
        //daily_mi();
      },
    );
  }

  Scaffold noInternet() {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No Internet Connection !!"),
            const SizedBox(
              height: 25,
            ),
            Center(child: const Icon(Icons.no_cell))
          ],
        ),
      )),
    );
  }

  Widget daily_mi(InternetState state) {
    return state == InternetState.InternetDisconnected
        ? noInternetConnection
        : FutureBuilder(
            future: getkygoAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("object ing ${snapshot.data}");
                if (snapshot.data != "Error occured") {
                  print('in error occured');
                  //  kygoAlbum = snapshot.data as albumfile.Album;
                }
                return Scaffold(
                  body: Stack(
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 66, 66, 80),
                      ),
                      SafeArea(
                        child: SingleChildScrollView(
                          // physics: BouncingScrollPhysics(),
                          controller: scrollController,
                          child: Column(
                            children: [mixTheme(context), mixSongs(context)],
                          ),
                        ),
                      ),
                      appBarAndPlayButton(context)
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print("object error");
                return const Scaffold(
                  body: SafeArea(
                      child: Center(child: CircularProgressIndicator())),
                );
              } else {
                print("object aiting");

                return const Scaffold(
                  body: SafeArea(
                      child: Center(child: CircularProgressIndicator())),
                );
              }
              /* switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                print("object aiting");
                print("object aiting ${snapshot.data}");
                // TODO: Handle this case.
                return const Scaffold(
                  body: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                print("object active");
                if (snapshot.hasData && snapshot.data != "Error occured") {
                  kygoAlbum = snapshot.data as albumfile.Album;
                  return Scaffold(
                    body: Stack(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 66, 66, 80),
                        ),
                        SafeArea(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [mixTheme(context), mixSongs(context)],
                            ),
                          ),
                        ),
                        appBarAndPlayButton(context)
                      ],
                    ),
                  );
                } else {
                  return const Scaffold(
                    body: CircularProgressIndicator(),
                  );
                }
              default:
                print("object default");
                return const Scaffold(
                  body: CircularProgressIndicator(),
                );
            }*/
            });
  }

  late AnimatedOpacity topB;
  /* Positioned appBarAndPlayButton(BuildContext context) {
    return Positioned(
      child: SafeArea(
          child: Container(
        //width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        decoration: BoxDecoration(
          color: imageSize > 84 ? Colors.transparent : Colors.grey[800],
          /* gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(1)
                    ])*/
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 30,
          child: Stack(
            clipBehavior: Clip.none,
            //alignment: Alignment.center,
            children: [
              InkResponse(
                onTap: () {
                  print("preeee");
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Positioned(
                left: 50,
                child: Text(
                  "Daily Mix 2",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color:
                            imageSize > 84 ? Colors.transparent : Colors.white,
                      ),
                ),
              ),
              Positioned(
                  right: 0,
                  bottom: (-containerHeight + offset) > -53
                      ? -53
                      : -containerHeight + offset,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(Icons.play_arrow,
                        size: 40, color: Colors.black),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff14d860)),
                    height: 64,
                    width: 64,
                  ))
            ],
          ),
        ),
      )),
    );
  }
 */
  Positioned appBarAndPlayButton(BuildContext context) {
    return Positioned(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          topbar(context),
          Positioned(
              right: 0,
              bottom: topbar(context).opacity == 1
                  ? -40
                  : (-containerHeight + 30) + offset, //-containerHeight + 80,
              /*(-containerHeight + offset) > -50
                      ? -30
                      : -containerHeight + offset + 50,*/
              child: Container(
                alignment: Alignment.center,
                child:
                    const Icon(Icons.play_arrow, size: 40, color: Colors.black),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff14d860)),
                height: 50,
                width: 50,
              ))
        ],
      ),
    );
  }

  AnimatedOpacity topbar(BuildContext context) {
    return AnimatedOpacity(
      opacity: imageSize < 70 ? 1 : 0,
      duration: const Duration(milliseconds: 1),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 66, 66, 80)),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50, // offset > 400 ? 80 : 0,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 10),
              child: Row(
                children: [
                  InkResponse(
                    onTap: () {
                      print("preeee");
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Daily Mix 2",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container mixSongs(BuildContext context) {
    print('total track: ${widget.album.tracks![0].artists[0].name}');
    print('trackc: ${widget.album.tracks}');
    print('image: ${widget.album.images}');
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: 1000,
      child: Column(
        children: [
          ...List.generate(int.parse(widget.album.total_tracks), (index) {
            albumfile.Track track = widget.album.tracks![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListTile(
                leading: Container(
                  child: Image(
                      image: NetworkImage(widget.album.images![0].url),
                      fit: BoxFit.cover), //const Icon(Icons.favorite),
                  //padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      /* borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),*/
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, colors: [
                    Colors.blue,
                    //Colors.purple,
                    Colors.white70
                  ])),
                ),
                title: Text(track.name, //"SOS (feat.Aloe Blacc)",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 15)),
                trailing: const Icon(Icons.more_vert, color: Colors.grey),
                subtitle: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 12),
                        children: List.generate(track.artists!.length, (index) {
                          return index != track.artists!.length - 1
                              ? TextSpan(
                                  text: "${track.artists![index].name}, ")
                              : TextSpan(text: track.artists![index].name);
                        }))), //Text("${track.artists[0].name}}", //"Avicii, Aloe Blacc",
              ),
            );
          })
        ],
      ),
      color: Colors.black.withOpacity(1),
    );
  }

  Container mixTheme(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          findInPlaylistMenu(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Center(
              child: AnimatedOpacity(
                opacity: imageSize < 162 ? 0 : 1,
                duration: const Duration(seconds: 1),
                child: Container(
                  //margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 20),
                        blurRadius: 20,
                        spreadRadius: 10)
                  ]),
                  height: imageSize,
                  width: imageSize,
                  child: Image(
                      image: NetworkImage(widget.album.images![0].url),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Text(
              "${widget.album.artists![0].name} : ${widget.album.name} ", //"Anne-Marie, Dra Project, Tom Grennan and more",
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Made for ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 14)),
            const TextSpan(
                text: 'Elyupapa', style: TextStyle(fontWeight: FontWeight.bold))
          ])),
          const SizedBox(
            height: 5,
          ),
          Text(
            '2h 41min',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(children: const [
            Icon(
              Icons.favorite_border_outlined,
            ),
            SizedBox(width: 20),
            Icon(Icons.more_vert),
          ])
        ]),
      ),
      height: containerHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(1)
          ])),
    );
  }

  findInPlaylistMenu() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Row(
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      hintText: "Find in playlist",
                      filled: true,
                      /*constraints:
                          const BoxConstraints(maxHeight: 40, minHeight: 40),*/
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 15),
                      fillColor: const Color.fromARGB(255, 66, 66, 80),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)))),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 66, 66, 80),
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Sort",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
