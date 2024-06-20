import 'package:flutter/material.dart';
import 'package:pecs_app/models/schedule_list_model.dart';
import 'package:pecs_app/services/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'schedule_activity_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Consumer<ScheduleListProvider>(
        builder: (context, scheduleListProvider, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: scheduleListProvider.scheduleList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              ScheduleModel schedule = scheduleListProvider.scheduleList[index];
              return ScheduleItem(schedule: schedule);
            },
          );
        },
      ),
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () => scheduledActivityPage(context),
          child: const Icon(Icons.add, size: 40),
        ),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(schedule.picModel.path),
          const SizedBox(height: 10),
          Text(
            schedule.selectedTime.format(context),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
