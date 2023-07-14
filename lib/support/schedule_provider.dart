import 'package:flutter/material.dart';
import '../models/schedule_list_model.dart';


class ScheduleListProvider with ChangeNotifier {
  List<ScheduleModel> _scheduleList = [];

  List<ScheduleModel> get scheduleList => _scheduleList;

  void addSchedule(ScheduleModel scheduleModel) {
    _scheduleList.add(scheduleModel);
    notifyListeners();
  }
}