import 'package:flutter/material.dart';
import 'package:pecs_app/SCHEDULE/schedule_activity_screen.dart';
import '../draggable_pics_data.dart';


class ChooseScheduleActivityScreen extends StatefulWidget{

  @override
  State<ChooseScheduleActivityScreen> createState() => _ChooseScheduleActivityScreenState();
}

class _ChooseScheduleActivityScreenState extends State<ChooseScheduleActivityScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Figuras'),
        ),
        body: GridView.builder(
          itemCount: PICTOGRAMS.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // adjust according to your needs
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () { Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleActivityScreen(picModel: PICTOGRAMS[index]),
                ),
              );},
              child: Image.asset(PICTOGRAMS[index].path),
            );
          },
        )
    );
  }

}

