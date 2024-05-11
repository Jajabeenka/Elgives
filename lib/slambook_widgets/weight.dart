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
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
            onSaved: (val) {
              print("Text value: ${val!}");
            },
            validator: (val) {
              // we used the val parameter for checking instead of the value inside the variable
              if (val == null || val.isEmpty) return "Enter an Weight";
              if (int.tryParse(val) == null) return "Enter a valid Weight";
            },
            // an onChanged property is placed to call the callback function
            onChanged: (value) {
              // we're not going to save the value of the text inside a separate variable anymore because we're going to pass it directly to the parent widget
              widget.callback(value);
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Weight",
                hintText: "Enter your Weight",
                hintStyle: TextStyle(color: Color.fromARGB(225, 94, 99, 104))),
          ),
        ],
      ),
    );
  }
}
