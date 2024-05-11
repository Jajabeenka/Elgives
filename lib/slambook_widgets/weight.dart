import 'package:flutter/material.dart';

class Weight extends StatefulWidget {
  final Function callback;
  const Weight(this.callback, {super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Enter Weight:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              onSaved: (val) {
                print("Text value: ${val!}");
              },
              validator: (val) {
                if (val == null || val.isEmpty) return "Enter a Weight";
                if (int.tryParse(val) == null) return "Enter a valid Weight";
                return null;
              },
              onChanged: (value) {
              widget.callback(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your Weight",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
