import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pecs_app/widgets/custom_app_bar.dart';
import 'package:pecs_app/widgets/draggable_pic.dart';
import 'package:pecs_app/data/higiene/higiene_draggable_pics_data.dart';
import 'package:pecs_app/data/corpo/corpo_draggable_pics_data.dart';
import 'package:pecs_app/data/comunicacao/comunicacao_draggable_pics_data.dart';
import 'package:pecs_app/services/tts_service.dart';
import 'package:pecs_app/models/draggable_pic_model.dart';

import '../../data/atividades/atividades_draggable_pics_data.dart';

class PicsScreen extends StatefulWidget {
  @override
  State<PicsScreen> createState() => _PicsScreenState();
}

class _PicsScreenState extends State<PicsScreen> {
  final TtsService _ttsService = TtsService();
  List<DraggablePicModel> acceptedData = [];
  final Queue<String> _textQueue = Queue<String>();
  bool _isSpeaking = false;
  List<DraggablePicModel> currentPictograms = higieneDraggable;

  void _selectPictograms(List<DraggablePicModel> pictograms) {
    setState(() {
      currentPictograms = pictograms;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:'PECS',
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
            Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Atividades',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectPictograms(atividadesDraggable),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Higiene',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectPictograms(higieneDraggable),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: Text(
                'Corpo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectPictograms(corpoDraggables),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.record_voice_over),
              title: Text(
                'Comunicação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectPictograms(comunicacaoDraggable),
            ),
            Divider(),
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
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: 10, // Adjust the height of the stripe as needed
                  color: Colors.brown,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
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
            ),
          ],
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
