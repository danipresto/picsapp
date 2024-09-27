import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PecsSpeak/models/draggable_pic_model.dart';

class DraggablePic extends StatelessWidget {
  final DraggablePicModel picModel;

  DraggablePic(this.picModel);

  @override
  Widget build(BuildContext context) {
    return Draggable<DraggablePicModel>(
      data: picModel,
      feedback: Material(
        child: Image.asset(picModel.path, width: 100.0, height: 100.0),
        color: Colors.transparent,
      ),
      child: Image.asset(picModel.path, width: 100.0, height: 100.0),
    );
  }
}