import 'package:flutter/material.dart';

Future<dynamic> showSortByBottomsheet(BuildContext context, List sortingOptions,
    String sortBy, void Function(int index) onOptionTap) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Text("Sort by",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              //printTitle("Sort by"),
              ...List.generate(sortingOptions.length, (index) {
                if (sortBy == sortingOptions[index]) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        InkResponse(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            sortingOptions[index],
                            style: TextStyle(
                                color: Colors.green[800], fontSize: 18),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.check,
                          color: Colors.green[800],
                        )
                      ],
                    ),
                  );
                } else {
                  return InkResponse(
                    onTap: () {
                      onOptionTap(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        sortingOptions[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                }
              }),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500])),
                    ),
                  ))
            ],
          ),
        );
      });
}
