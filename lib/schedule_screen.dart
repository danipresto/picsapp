import 'package:flutter/material.dart';
import 'package:pecs_app/draggable_pic.dart';
import 'package:pecs_app/draggable_pics_data.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ScheduleScreen extends StatefulWidget{

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agenda'),
        ),

        body:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('Criar Nova Atividade',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                    ),
                    onTap: () {
                      // Action to be performed when the user taps on "Criar Nova Atividade"
                    },
                  ),
                  ListTile(
                    title: Text('Editar Atividade',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Action to be performed when the user taps on "Editar Atividade"
                    },
                  ),
                ]
            )
    );

  }

}

