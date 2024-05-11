import 'package:flutter/material.dart';
import '../provider/donation_provider.dart';
import '../slambook_widgets/time.dart';
import '../slambook_widgets/weight.dart';
import '../slambook_widgets/mode.dart';
import '../slambook_widgets/address.dart';
import '../slambook_widgets/date.dart';
import '../slambook_widgets/item.dart';
import '../slambook_widgets/drawer.dart';
import '../slambook_widgets/contactNum.dart';
import '../models/donation.dart'; // Import the Friend class
import 'package:provider/provider.dart';
import '../provider/orgs_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation.dart';


class FormSample extends StatefulWidget {

  const FormSample({Key? key}) : super(key: key);

  @override
  State<FormSample> createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  final _formKey = GlobalKey<FormState>();

  bool showText = false;
  List<String> categories = [];
  String pickupOrDropOff = "PickUp";
  String weight = "";
  String? photo;
  DateTime dateTime = DateTime.now();
  List<String> addresses = [];
  String contact = "";

  void resetFields() {
  setState(() {
    categories = []; 
    pickupOrDropOff = "PickUp"; 
    weight = ""; 
    photo = null; 
    dateTime = DateTime.now(); 
    addresses = []; 
    contact = "";
  });

  setState(() {
    pickDrop = Mode(
      initialValue: 'Pickup',
      onChanged: (initialValue) {
        setState(() {
          pickupOrDropOff = initialValue;
        });
      },
    );
  });
  setState(() {
    dateTime = DateTime.now();
  });
  setState(() {
    dateTime = DateTime(
      TimeOfDay.now().hour,
      TimeOfDay.now().minute,
    );
  });
}

  late Mode pickDrop;

  @override
  Widget build(BuildContext context) {
    pickDrop = Mode(
      initialValue: 'Pickup', //initial value
      onChanged: (value) {
        setState(() {
          pickupOrDropOff = value; // Update superpower
        });
      },
    );

    return Scaffold(
      // margin: EdgeInsets.all(20),
      drawer: DrawerWidget(text: "Slambook"),
      appBar: AppBar(
        title: Text(
          "Donate Page",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 168, 202, 235)),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 168, 202, 235)),
      ),
      backgroundColor: Color.fromARGB(255, 5, 12, 49), //
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'NAME OR ORG',
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 168, 202, 235),
                ),
              ),
              Item(
                onChanged: (selectedOptions) {
                  setState(() {
                    categories = selectedOptions;
                  });
                },
                selectedOptions: categories,
              ),
              pickDrop,
              Weight((value) {
                setState(() {
                  weight = value;
                });
              }),
              Date((date) {
                setState(() {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                  );
                });
              }),
              Time((time) {
                setState(() {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    time.hour,
                    time.minute,
                  );
                });
              }),
              Address((addressList) {
                setState(() {
                  addresses = addressList;
                });
              }),
              contactNumber((value) {
                setState(() {
                  contact = value;
                });
              }),
              Container(
                margin: EdgeInsets.all(20),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color.fromARGB(255, 71, 73, 195)!),
                  ),
                  onPressed: () {
                    // if inputs are valid, then show text
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      Donation donation = (Donation(
                        categories: categories,
                        pickupOrDropOff: pickupOrDropOff,
                        weight: weight,
                        // photo: ,
                        dateTime: dateTime,
                        addresses: addresses,
                        contactNumber: contact,
                      ));
                      setState(() {
                        showText = true;
                      });
                      context
                          .read<DonationProvider>()
                          .addDonation(donation);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Donation added!"),
                        duration:
                            const Duration(seconds: 1, milliseconds: 100),
                      ));
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Divider(
                color: Colors.blue,
                thickness: 3.5,
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red[900]!),
                  ),
                  onPressed: () {
                    _formKey.currentState!.reset();
                    resetFields(); // Reset
                    setState(() {
                      showText = false;
                      // Status.resetStat(stat);
                    });
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
