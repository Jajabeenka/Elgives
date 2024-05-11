import 'package:flutter/material.dart';

class Date extends StatefulWidget {
  final Function(DateTime) callback;

  const Date(this.callback, {Key? key}) : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.callback(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(
              selectedDate != null
                  ? 'Selected Date: ${selectedDate!.toString().split(' ')[0]}'
                  : 'Select Date',
              style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
            ),
          ),
        ],
      ),
    );
  }
}
