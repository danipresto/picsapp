import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pecs_app/widgets/draggable_pic.dart';
import 'package:pecs_app/data/atividades/atividades_draggable_pics_data.dart';
import 'package:pecs_app/data/corpo/corpo_draggable_pics_data.dart';
import 'package:pecs_app/data/comunicacao/comunicacao_draggable_pics_data.dart';
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
  List<DraggablePicModel> currentPictograms = atividadesDraggable;

  void _selectPictograms(List<DraggablePicModel> pictograms) {
    setState(() {
      currentPictograms = pictograms;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figuras'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Atividades'),
              onTap: () => _selectPictograms(atividadesDraggable),
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Corpo'),
              onTap: () => _selectPictograms(corpoDraggables),
            ),
            ListTile(
              leading: const Icon(Icons.record_voice_over),
              title: const Text('Comunicação'),
              onTap: () => _selectPictograms(comunicacaoDraggable),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnWidth = 30.0; // Item width + spacing
          final columns = 4;

          return Stack(
            children: [
              Row(
                children: List.generate(columns, (index) {
                  return Container(
                    width: columnWidth - 10.0, // Subtract spacing to fit exactly
                    color: Colors.brown[200], // Light brown color
                    margin: const EdgeInsets.only(
                        right: 35.0,
                        left:  40.0
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: currentPictograms.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final pic = currentPictograms[index];
                    return DraggablePic(pic);
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.amber[600],
        child: _buildDragTarget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playAcceptedData,
        backgroundColor: Colors.green,
        child: Image.asset('resources/speech.png', width: 50, height: 50),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<DraggablePicModel>(
      builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber[600],
            borderRadius: BorderRadius.circular(10),
          ),
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
