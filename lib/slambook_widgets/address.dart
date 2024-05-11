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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white), 
        color: Color.fromARGB(255, 5, 85, 26), 
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: addresses.length + 1,
            itemBuilder: (context, index) {
              if (index == addresses.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addresses.add('');
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.yellow.shade600),
                        SizedBox(width: 10),
                        Text(
                          'Add Address',
                          style: TextStyle(color: Colors.yellow.shade600), 
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 5, 85, 26),), 
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: TextFormField(
                  initialValue: addresses[index],
                  style: TextStyle(
                    color: Colors.yellow.shade600, 
                    fontSize: 16,
                  ),
                  onChanged: (value) {
                    addresses[index] = value;
                    widget.callback(addresses);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Address ${index + 1}",
                    hintText: "Enter your Address",
                    hintStyle: TextStyle(color: Colors.grey), 
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
