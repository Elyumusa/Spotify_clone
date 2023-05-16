import 'package:flutter/material.dart';

class CategoryPicker extends StatefulWidget {
  List<String> tabItems = ['All', 'Shirts', 'Jewerly', 'Hoodies', 'Cosmetics'];
  Function whenTabChanges;
  bool usedInMyOrders = false;
  CategoryPicker(
      {required this.tabItems,
      required this.whenTabChanges,
      required this.usedInMyOrders});
  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<String>? tabItems;
  int currentTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: widget.tabItems.length, vsync: this);
    controller!.addListener(handleTabChanges);
    super.initState();
  }

  void handleTabChanges() {
    if (controller!.indexIsChanging) return;
    widget.whenTabChanges(controller!.index);
    setState(() {
      currentTab = controller!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: widget.tabItems
          .map((stringFromTab) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                          color: widget.tabItems[currentTab] == stringFromTab
                              ? Colors.green
                              : Colors.white),
                      color: widget.tabItems[currentTab] == stringFromTab
                          ? Colors.green
                          : Colors.black),
                  child: Text(
                    stringFromTab,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
          .toList(),
      indicatorColor: Colors.transparent,
      //labelColor: Colors.green,
      isScrollable: true,
      //unselectedLabelColor: Colors.transparent,
      controller: controller,
    );
  }
}
