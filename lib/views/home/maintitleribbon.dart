import 'package:flutter/material.dart';

class MainTitleRibbon extends StatelessWidget {
  const MainTitleRibbon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Good evening",
          style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.notifications_none_outlined),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.timelapse_outlined),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.settings_outlined),
        )
      ],
    );
  }
}
