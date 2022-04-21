import 'package:flutter/material.dart';

class Mainsong extends StatelessWidget {
  const Mainsong({
    Key? key,
    required this.containerHeight,
  }) : super(key: key);

  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      color: Colors.transparent,
      child: Column(children: [
        Container(
          width: 200,
          height: 300,
          color: Colors.white,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "XO Tour Llif3",
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 12,
        ),
        Text("Song Radio",
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16)),
        const SizedBox(
          height: 12,
        ),
      ]),
    );
  }
}
