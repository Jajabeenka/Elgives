import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  final Function(TimeOfDay) callback;

  const Time(this.callback, {Key? key}) : super(key: key);

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
            onPressed: () => _selectTime(context),
            child: Text(
              selectedTime != null
                  ? 'Selected Time: ${selectedTime!.format(context)}'
                  : 'Select Time',
              style: TextStyle(color: Color.fromARGB(255, 168, 202, 235)),
            ),
          ),
        ],
      ),
    );
  }
}
