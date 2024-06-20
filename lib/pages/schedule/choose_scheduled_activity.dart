import 'package:flutter/material.dart';
import 'package:pecs_app/data/atividades/atividades_draggable_pics_data.dart';
import 'package:pecs_app/models/draggable_pic_model.dart';

class ChooseScheduleActivityScreen extends StatefulWidget {
  @override
  State<ChooseScheduleActivityScreen> createState() => _ChooseScheduleActivityScreenState();
}

class _ChooseScheduleActivityScreenState extends State<ChooseScheduleActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolher Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: atividadesDraggable.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust according to your needs
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final activity = atividadesDraggable[index];
            return ActivityGridItem(activity: activity);
          },
        ),
      ),
    );
  }
}

class ActivityGridItem extends StatelessWidget {
  final DraggablePicModel activity;

  const ActivityGridItem({required this.activity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, activity); // Pop and pass the picModel back
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(activity.path),
        ),
      ),
    );
  }
}
