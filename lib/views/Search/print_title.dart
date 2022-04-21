import 'package:flutter/material.dart';

SliverToBoxAdapter printTitle(String title) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}
