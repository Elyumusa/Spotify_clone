import 'package:flutter/material.dart';

SliverAppBar searchMenu() {
  return SliverAppBar(
    foregroundColor: Colors.black,
    backgroundColor: Colors.black,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      titlePadding:
          const EdgeInsetsDirectional.only(start: 5, bottom: 8, end: 5),
      title: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              hintText: "Artists, songs or podcasts",
              filled: true,
              constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
              hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3)))),
      background: const Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: SafeArea(
          child: Text('Search',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    ),
    expandedHeight: 120.0,
    pinned: true,
  );
}
