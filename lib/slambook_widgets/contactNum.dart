import 'package:flutter/material.dart';

class contactNumber extends StatefulWidget {
  final Function callback;
  const contactNumber(this.callback, {super.key});

  @override
  State<contactNumber> createState() => _contactNumberState();
}

class _contactNumberState extends State<contactNumber> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white), 
        color: Color.fromARGB(255, 5, 85, 26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              style: TextStyle(
                color: Colors.yellow.shade600, 
                fontSize: 16,
              ),
              onSaved: (val) {
                print("Text value: ${val!}");
              },
              validator: (val) {
                if (val == null || val.isEmpty) return "Enter a contactNumber";
                if (int.tryParse(val) == null) return "Enter a valid contactNumber";
                return null;
              },
              onChanged: (value) {
              widget.callback(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Contact Number",
                hintText: "Enter your contactNumber",
                hintStyle: TextStyle(color: Colors.grey), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
