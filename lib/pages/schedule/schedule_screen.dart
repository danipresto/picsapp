import 'package:flutter/material.dart';
import 'package:pecs_app/models/schedule_model.dart';
import 'package:pecs_app/services/schedule_list_provider.dart';
import 'package:pecs_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:pecs_app/services/admin_mode_provider.dart';
import 'schedule_activity_screen.dart';
import 'package:pecs_app/pages/schedule/schedule_item.dart';

class ScheduleScreen extends StatelessWidget {
  void scheduledActivityPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ScheduleActivityScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdminMode = Provider.of<AdminModeProvider>(context).isAdminMode;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Agenda',
      ),
      body: Consumer<ScheduleListProvider>(
        builder: (context, scheduleListProvider, child) {
          // Sort the scheduleList by selectedTime
          List<ScheduleModel> sortedList = List.from(scheduleListProvider.scheduleList);
          sortedList.sort((a, b) {
            final aTime = TimeOfDay(hour: a.selectedTime.hour, minute: a.selectedTime.minute);
            final bTime = TimeOfDay(hour: b.selectedTime.hour, minute: b.selectedTime.minute);
            return aTime.hour.compareTo(bTime.hour) != 0
                ? aTime.hour.compareTo(bTime.hour)
                : aTime.minute.compareTo(bTime.minute);
          });

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: sortedList.length,
            itemBuilder: (BuildContext context, int index) {
              ScheduleModel schedule = sortedList[index];
              return ScheduleItem(schedule: schedule);
            },
          );
        },
      ),
      floatingActionButton: isAdminMode
          ? FloatingActionButton(
        onPressed: () => scheduledActivityPage(context),
        child: const Icon(Icons.add, size: 30),
      )
          : null,
    );
  }

}


