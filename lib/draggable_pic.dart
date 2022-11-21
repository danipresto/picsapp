import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraggablePic extends StatelessWidget{
  final String title;
  final String path;

  DraggablePic(this.title,this.path);

  @override
  Widget build(BuildContext context){

    return Draggable(
        child: Image(
            image: AssetImage(path)
        ),
        feedback:Image(
            image: AssetImage(path)
        )
    );
  }

}