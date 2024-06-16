import 'package:flutter/material.dart';
import 'package:pecs_app/data/atividades/draggable_pics_data.dart';


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
          itemCount: pictograms.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // adjust according to your needs
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pop(context, pictograms[index]); // pop and pass the picModel back
              },
              child: Image.asset(pictograms[index].path),
            );
          },
        )
    );
  }

}

