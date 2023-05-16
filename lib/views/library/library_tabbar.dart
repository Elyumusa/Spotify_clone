import 'package:flutter/material.dart';

class LibraryTabbar extends StatefulWidget {
  final List tabs;
  const LibraryTabbar({
    Key? key,
    required this.tabs,
  }) : super(key: key);
  @override
  State<LibraryTabbar> createState() => LibraryTabbarState();
}

class LibraryTabbarState extends State<LibraryTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        padding: const EdgeInsets.symmetric(vertical: 15),
        indicator: BoxDecoration(color: Colors.transparent),
        controller: _tabController,
        tabs: [
          ...List.generate(
              widget.tabs.length,
              (index) => Container(
                    margin: EdgeInsets.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    // ignore: prefer_const_constructors
                    child: Text(widget.tabs[index],
                        style: TextStyle(
                            //fontSize: 25,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        border: Border.all(color: Colors.grey.shade600)),
                  ))
        ]);
  }
}
