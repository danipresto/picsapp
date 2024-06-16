import 'package:flutter/material.dart';
import 'package:pecs_app/models/schedule_list_model.dart';
import 'package:pecs_app/services/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'schedule_activity_screen.dart';


class ScheduleScreen extends StatelessWidget {  // Changed to StatelessWidget since we're using Provider

  void scheduledActivityPage(BuildContext ctx){
    Navigator.of(ctx).push(
        MaterialPageRoute(
            builder: (_){
              return ScheduleActivityScreen();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Consumer<ScheduleListProvider>(  // Added Consumer here
        builder: (context, scheduleListProvider, child) {
          return GridView.builder(
            itemCount: scheduleListProvider.scheduleList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              ScheduleModel schedule = scheduleListProvider.scheduleList[index];
              return Container(
                child: Column(
                  children: [
                    Image.asset('${schedule.picModel.path}'),
                    Text(
                      '${schedule.selectedTime.format(context)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton:  Container(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () => scheduledActivityPage(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}

