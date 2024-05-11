import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  final Function(TimeOfDay) callback;
  final DateTime dateTime;
  const Time(this.callback, {Key? key, required this.dateTime}) : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.callback(TimeOfDay.fromDateTime(DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day, picked.hour, picked.minute)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white), 
        color: Color.fromARGB(255, 18, 103, 30), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextButton(
              onPressed: () => _selectTime(context),
              child: Text(
                selectedTime != null
                    ? 'Selected Time: ${selectedTime!.format(context)}'
                    : 'Select Time',
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
