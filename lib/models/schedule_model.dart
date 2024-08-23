import 'package:flutter/material.dart';
import 'draggable_pic_model.dart';

class ScheduleModel {
  final DraggablePicModel picModel;
  final TimeOfDay selectedTime;

  ScheduleModel({required this.picModel, required this.selectedTime});

  Map<String, dynamic> toJson() {
    return {
      'picModel': picModel.toJson(),
      'selectedTime': _timeOfDayToString(selectedTime),
    };
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      picModel: DraggablePicModel.fromJson(json['picModel']),
      selectedTime: _stringToTimeOfDay(json['selectedTime']),
    );
  }

  static String _timeOfDayToString(TimeOfDay time) {
    return time.hour.toString().padLeft(2, '0') +
        ':' +
        time.minute.toString().padLeft(2, '0');
  }

  static TimeOfDay _stringToTimeOfDay(String timeString) {
    final format = RegExp(r'^(\d{2}):(\d{2})$');
    final match = format.firstMatch(timeString);
    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      return TimeOfDay(hour: hours, minute: minutes);
    } else {
      return TimeOfDay.now(); // Fallback if parsing fails
    }
  }
}
