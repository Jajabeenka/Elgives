import 'package:flutter/material.dart';

class Date extends StatefulWidget {
  final Function(DateTime) callback;
  final DateTime dateTime;
  const Date(this.callback, {Key? key, required this.dateTime}) : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  DateTime? selectedDate;
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.callback(DateTime(picked.year, picked.month, picked.day, widget.dateTime.hour, widget.dateTime.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white), 
        color: Color.fromARGB(255, 21, 88, 25), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                selectedDate != null
                    ? 'Selected Date: ${selectedDate!.toString().split(' ')[0]}'
                    : 'Select Date',
                style: TextStyle(
                  color: Colors.yellow.shade600, 
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}