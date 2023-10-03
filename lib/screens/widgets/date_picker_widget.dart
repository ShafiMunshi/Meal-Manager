import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({super.key, required this.dateTime});

  DateTime dateTime;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: CupertinoDatePicker(
        backgroundColor: Colors.white,
        initialDateTime: widget.dateTime,
        onDateTimeChanged: (DateTime newtime) {
          setState(() {
            widget.dateTime = newtime;
          });
        },
        mode: CupertinoDatePickerMode.date,
        // showDayOfWeek: true,
        use24hFormat: true,
      ),
    );
  }
}
