import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pecs_app/widgets/draggable_pic.dart';
import 'package:pecs_app/data/atividades/draggable_pics_data.dart';
import 'package:pecs_app/services/tts_service.dart';
import 'package:pecs_app/models/draggable_pic_model.dart';

class PicsScreen extends StatefulWidget {
  @override
  State<PicsScreen> createState() => _PicsScreenState();
}

class _PicsScreenState extends State<PicsScreen> {
  final TtsService _ttsService = TtsService();
  List<DraggablePicModel> acceptedData = [];
  final Queue<String> _textQueue = Queue<String>();
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figuras'),
      ),
      body: Column(
        children: [
          Flexible(
            child: GridView(
              padding: const EdgeInsets.all(10),
              children: pictograms.map((picsdata) => DraggablePic(picsdata)).toList(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
          _buildDragTarget(),
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            child: FloatingActionButton(
              onPressed: _playAcceptedData,
              backgroundColor: Colors.green,
              child: Image.asset('resources/speech.png', width: 50, height: 50),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<DraggablePicModel>(
      builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber[600],
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: acceptedData.map((data) {
              return Draggable<DraggablePicModel>(
                data: data,
                feedback: Image.asset(data.path, width: 100, height: 100),
                childWhenDragging: Container(),
                child: Image.asset(data.path, width: 100, height: 100),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    acceptedData.remove(data);
                  });
                },
              );
            }).toList(),
          ),
        );
      },
      onWillAccept: (data) {
        return data != null && acceptedData.length < 3;
      },
      onAccept: (data) {
        setState(() {
          acceptedData.add(data);
        });
      },
    );
  }

  Future<void> _playAcceptedData() async {
    for (DraggablePicModel data in acceptedData) {
      _textQueue.add(data.title);
    }
    _processQueue();
  }

  void _processQueue() async {
    if (_isSpeaking || _textQueue.isEmpty) return;

    _isSpeaking = true;
    String text = _textQueue.removeFirst();
    await _ttsService.speak(text);
    _isSpeaking = false;

    if (_textQueue.isNotEmpty) {
      _processQueue();
    } else {
      setState(() {
        acceptedData.clear();
      });
    }
  }
}
