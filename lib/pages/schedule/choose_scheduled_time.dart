import 'package:flutter/material.dart';

class ChooseScheduledTimeScreen extends StatefulWidget {
  @override
  _ChooseScheduledTimeScreenState createState() => _ChooseScheduledTimeScreenState();
}

class _ChooseScheduledTimeScreenState extends State<ChooseScheduledTimeScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Selected time: ${selectedTime.format(context)}'),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 20), // optional, for extra space
            ElevatedButton(
              onPressed: () => Navigator.pop(context, selectedTime),
              child: Text(
                'Escolher Horário',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}