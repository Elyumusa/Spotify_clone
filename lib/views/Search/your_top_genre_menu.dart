import 'package:flutter/material.dart';

SliverToBoxAdapter yourTopGenresMenu() {
  return SliverToBoxAdapter(
      child: Column(
    children: [
      ...List.generate(
          2,
          (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 190,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 190,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ),
              ))
    ],
  ));
}
