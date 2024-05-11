import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  final Function(List<String>) callback;

  const Address(this.callback, {Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<String> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: addresses.length + 1,
            itemBuilder: (context, index) {
              if (index == addresses.length) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addresses.add('');
                    });
                  },
                  child: Icon(Icons.add),
                );
              }
              return TextFormField(
                initialValue: addresses[index],
                style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
                onChanged: (value) {
                  addresses[index] = value;
                  widget.callback(addresses);
                },
                decoration: InputDecoration(
                  hoverColor: Color.fromARGB(255, 168, 202, 235),
                  border: OutlineInputBorder(),
                  labelText: "Address ${index + 1}",
                  hintText: "Enter your Address",
                  hintStyle: TextStyle(color: Color.fromARGB(225, 94, 99, 104)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
