import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pecs_app/draggable_pic.dart';
import 'package:pecs_app/draggable_pics_data.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pecs_app/models/draggable_pic_model.dart';


class PicsScreen extends StatefulWidget{

  @override
  State<PicsScreen> createState() => _PicsScreenState();
}

class _PicsScreenState extends State<PicsScreen> {
  final FlutterTts flutterTts = FlutterTts();
  List<DraggablePicModel> acceptedData = [];

  @override
  Widget build(BuildContext context){

    Future<void> speakAndWait(FlutterTts tts, String text) {
      final Completer<void> completer = Completer();
      tts.setProgressHandler((String text, int start, int end, String word) {
        if (end >= text.length) {
          completer.complete();
        }
      });
      flutterTts.setLanguage("pt-BR");
      flutterTts.setPitch(1.0);
      flutterTts.speak(text);
      return completer.future;
    }


    return Scaffold(
        appBar: AppBar(
          title: const Text('Figuras'),
        ),
        body: Column(
            children: [
              Flexible(child: GridView(
                children: pictograms.map((picsdata) => DraggablePic(picsdata)).toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
              )

              ),
              DragTarget<DraggablePicModel>(
                builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected){
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.amber[600],
                      width: MediaQuery.of(context).size.width,
                      height: 90.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: acceptedData.map((data) => Image.asset(data.path)).toList(),
                      ),
                    ),
                  );
                },
                onWillAccept: (data){
                  return data != null && acceptedData.length < 3;
                },
                onAccept: (data){
                  setState(() {
                    acceptedData.add(data);
                  });
                },
              ),
              FloatingActionButton(
                onPressed: () async {
                  for (DraggablePicModel data in acceptedData) {
                    await speakAndWait(flutterTts, data.title);
                  }
                  setState(() {
                    acceptedData.clear();
                  });
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.play_arrow),
              ),
            ]
        )

    );
  }
}


