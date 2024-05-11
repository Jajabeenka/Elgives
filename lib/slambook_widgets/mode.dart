import 'package:flutter/material.dart';

class Mode extends StatefulWidget {
  final Function(String) onChanged;
  final String initialValue;

  Mode({
    Key? key,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  _ModeState createState() => _ModeState();

  static final List<String> _dropdownOptions = [
    "Pickup",
    "Drop-off",
  ];
}

class _ModeState extends State<Mode> {
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
            value: _dropdownValue,
            items: Mode._dropdownOptions.map((option) {
              return DropdownMenuItem<String>(
                child: Text(
                  option,
                  style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
                ),
                value: option,
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                _dropdownValue = val!;
              });
              widget.onChanged(val!);
            },
          )
        ],
      ),
    );
  }
}
