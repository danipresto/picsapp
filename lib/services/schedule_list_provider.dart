import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pecs_app/models/schedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleListProvider with ChangeNotifier {
  List<ScheduleModel> _scheduleList = [];

  List<ScheduleModel> get scheduleList => _scheduleList;

  ScheduleListProvider() {
    _loadScheduleList();
  }

  void addSchedule(ScheduleModel schedule) {
    _scheduleList.add(schedule);
    _saveScheduleList();
    notifyListeners();
  }

  void removeSchedule(ScheduleModel schedule) {
    _scheduleList.remove(schedule);
    _saveScheduleList();
    notifyListeners();
  }

  void _saveScheduleList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scheduleJsonList = _scheduleList
        .map((schedule) => jsonEncode(schedule.toJson()))
        .toList();
    prefs.setStringList('scheduleList', scheduleJsonList);
  }

  void _loadScheduleList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? scheduleJsonList = prefs.getStringList('scheduleList');

    if (scheduleJsonList != null) {
      _scheduleList = scheduleJsonList
          .map((scheduleJson) =>
          ScheduleModel.fromJson(jsonDecode(scheduleJson)))
          .toList();
    }

    notifyListeners();
  }
}
