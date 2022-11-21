import 'package:flutter/material.dart';
import 'package:pecs_app/draggable_pic.dart';
import 'package:pecs_app/draggable_pics_data.dart';

class PicsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return GridView(
      children: PICTOGRAMS.map((picsdata) => DraggablePic(
          picsdata.title,
          picsdata.path
      ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
      ),
    );
  }

}