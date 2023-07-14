import 'package:flutter/material.dart';
import 'draggable_pic_model.dart';

class ScheduleModel {
  final DraggablePicModel picModel;
  final TimeOfDay selectedTime;

  ScheduleModel({required this.picModel, required this.selectedTime});
}