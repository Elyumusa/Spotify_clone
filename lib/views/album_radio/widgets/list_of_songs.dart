import 'package:flutter/material.dart';

class listOfsongs extends StatelessWidget {
  const listOfsongs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20),
            child: Center(
                child: Text(
              "In this station",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.normal),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text.rich(TextSpan(
                text:
                    "Oh Wonder, Lil Mosey, French Montana, sae Lee, Offset, and more.",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.normal))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
                child: Text(
              "Songs",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.normal),
            )),
          ),
          ...List.generate(
              36,
              (index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The Way Life Goes (feat. Oh Wonder)",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                            ),
                            Text(
                              "Lil Uzi Vert-Luv is Rage 2",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_vert)
                      ],
                    ),
                  ))
        ]),
      ),
    );
  }
}
