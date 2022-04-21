import 'package:flutter/material.dart';

import 'widgets/list_of_songs.dart';
import 'widgets/main_song.dart';

class AlbumRadio extends StatefulWidget {
  const AlbumRadio({Key? key}) : super(key: key);

  @override
  State<AlbumRadio> createState() => _AlbumRadioState();
}

class _AlbumRadioState extends State<AlbumRadio> {
  ScrollController scrollController = ScrollController();
  double containerHeight = 500;
  double offset = 0;
  @override
  void initState() {
    scrollController.addListener(() {
      offset = scrollController.offset;
      print("${scrollController.offset}");
      print(-containerHeight + offset);
      print("containerHeight: $containerHeight");
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 66, 66, 80),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(children: [
                Mainsong(containerHeight: containerHeight),
                listOfsongs()
              ]),
            ),
          ),
          appBarAndPlayButton(context)
        ],
      ),
    );
  }

  Positioned appBarAndPlayButton(BuildContext context) {
    return Positioned(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              //width: double.infinity,
              /*padding:
              const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 20),*/
              decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 66, 66, 80)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100, // offset > 400 ? 80 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 20, top: 10),
                  child: Row(
                    children: [
                      InkResponse(
                        onTap: () {
                          print("preeee");
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        //height: 100,
                        child: AnimatedOpacity(
                          opacity: offset > 400 ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          child: Text(
                            "Sangalala",
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.white
                                // imageSize > 84 ? Colors.transparent : Colors.white,
                                ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                //right: 0,
                bottom: offset > 400 ? -40 : (-containerHeight + 60) + offset,
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow,
                            size: 40, color: Colors.black),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Play radio",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black))
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      //shape: BoxShape.circle,
                      color: const Color(0xff14d860)),
                  height: 64,
                  //width: 64,
                ))
          ],
        ),
      ),
    );
  }
}
