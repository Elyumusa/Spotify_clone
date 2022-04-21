import 'package:flutter/material.dart';

AppBar libraryAppBar() {
  return AppBar(
      backgroundColor: Colors.black,
      leading: Container(
        //padding: const EdgeInsets.all(value),
        //height: 10,
        //width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(70),
            color: Colors.purple.shade700),
        child: Center(
          child: const Text(
            'E',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
      title: const Text('Your Library',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
      elevation: 0,
      actions: const [
        Icon(Icons.search),
        SizedBox(width: 10),
        Icon(Icons.add)
      ]);
}
