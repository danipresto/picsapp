import 'package:flutter/material.dart';
import 'package:PecsSpeak/data/higiene/higiene_draggable_pics_data.dart';
import 'package:PecsSpeak/data/atividades/atividades_draggable_pics_data.dart'; // Import atividades data
import 'package:PecsSpeak/models/draggable_pic_model.dart';
import 'package:PecsSpeak/widgets/custom_app_bar.dart';


class ChooseScheduleActivityScreen extends StatefulWidget {
  @override
  State<ChooseScheduleActivityScreen> createState() => _ChooseScheduleActivityScreenState();
}

class _ChooseScheduleActivityScreenState extends State<ChooseScheduleActivityScreen> {
  List<DraggablePicModel> combinedList = [];

  @override
  void initState() {
    super.initState();
    // Combine the two lists
    combinedList = [...higieneDraggable, ...atividadesDraggable];
    // Sort the combined list alphabetically by title
    combinedList.sort((a, b) => a.title.compareTo(b.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Escolher Atividade',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: combinedList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust according to your needs
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final activity = combinedList[index];
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
