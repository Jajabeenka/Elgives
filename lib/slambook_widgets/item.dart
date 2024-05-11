import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final Function(List<String>) onChanged;
  final List<String> selectedOptions;

  const Item({
    Key? key,
    required this.onChanged,
    required this.selectedOptions,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late List<String> _ItemOptions;

  @override
  void initState() {
    super.initState();
    _ItemOptions = [
      "Foods",
      "Clothes",
      "Cash",
      "Necessities",
      "Others",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var Item in _ItemOptions)
            CheckboxListTile(
              title: Text(
                Item,
                style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
              ),
              value: widget.selectedOptions.contains(Item),
              onChanged: (bool? checked) {
                setState(() {
                  if (checked!) {
                    widget.selectedOptions.add(Item);
                  } else {
                    widget.selectedOptions.remove(Item);
                  }
                });
                widget.onChanged(widget.selectedOptions);
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.blue, // Customize the color if needed
            ),
        ],
      ),
    );
  }
}
