import 'package:flutter/material.dart';
import 'package:pecs_app/draggable_pic.dart';
import 'package:pecs_app/draggable_pics_data.dart';
import 'package:flutter_tts/flutter_tts.dart';




class PicsScreen extends StatefulWidget{

  @override
  State<PicsScreen> createState() => _PicsScreenState();
}


class _PicsScreenState extends State<PicsScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context){

    void speak(String text) async {
      await flutterTts.setLanguage("pt-BR");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Figuras'),
        ),
        body: Column(
            children: [
              Flexible(child: GridView(
                children: PICTOGRAMS.map((picsdata) => DraggablePic(
                    picsdata.title,
                    picsdata.path
                )
                ).toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
              )
              ),
              DragTarget<String>(
                builder: (BuildContext context,List<dynamic> accepted,List<dynamic> rejected){
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.amber[600],
                      width: MediaQuery.of(context).size.width,
                      height: 90.0,
                    ),
                  );
                },
                onWillAccept: (data){
                  return data != '';
                },
                onAccept: (data){
                  speak(data);
                },
              ),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.green,
                child: const Icon(Icons.play_arrow),
              ),
            ]
        )

    );
  }
}


