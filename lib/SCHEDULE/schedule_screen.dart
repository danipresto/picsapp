import 'package:flutter/material.dart';
import '../models/draggable_pic_model.dart';
import 'schedule_activity_screen.dart';

class ScheduleModel {
  final DraggablePicModel picModel;
  final TimeOfDay selectedTime;

  ScheduleModel({required this.picModel, required this.selectedTime});
}

class ScheduleScreen extends StatefulWidget {

  final List<ScheduleModel>? scheduleList;

  ScheduleScreen({this.scheduleList});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  void scheduledActivityPage(BuildContext ctx){
    Navigator.of(ctx).push(
        MaterialPageRoute(
            builder: (_){
              return ScheduleActivityScreen();
            }
        )
    );
  }

  List<IconData> icons = [];

  void addIcon(IconData icon) {
    setState(() {
      icons.add(icon);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),

      body: GridView.builder(
        itemCount: widget.scheduleList?.length ?? 0, // change this to the number of items
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (widget.scheduleList?[index].picModel == null) {
            return Center(
              child: Text(
                '',
                style: TextStyle(fontSize: 24), // Change the size as per your requirement
              ),
            );
          }
          return Container(
            child: Column(
              children: [
                Text('Title: ${widget.scheduleList![index].picModel.title}'),
                Image.asset('${widget.scheduleList![index].picModel.path}'),
                Text('Selected Time: ${widget.scheduleList![index].selectedTime.format(context)}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton:  Container(
        width: 100, // Set the desired width
        height: 100, // Set the desired height
        child: FloatingActionButton(
          onPressed: () => scheduledActivityPage(context),
          child: Icon(Icons.add),
        ),
      ),
    );

  }

}

