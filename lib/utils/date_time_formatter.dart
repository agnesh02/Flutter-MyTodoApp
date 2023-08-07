import 'package:flutter/material.dart';

String formatSelectedDate(DateTime val) {
  return "${val.day} / ${val.month} / ${val.year}";
}

String formatSelectedTime(TimeOfDay timeOfDay) {
  String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
  int hour = timeOfDay.hourOfPeriod;
  int minute = timeOfDay.minute;

  String hourString = (hour % 12).toString().padLeft(2, '0');
  String minuteString = minute.toString().padLeft(2, '0');

  return '$hourString:$minuteString $period';
}
