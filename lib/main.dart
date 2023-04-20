import 'package:flutter/material.dart';
import 'package:pecs_app/pics_screen.dart';
import 'package:pecs_app/schedule_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber
      ),
      home: const MyHomePage(title: 'AssisPics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void selectFigurasPage(BuildContext ctx){
    Navigator.of(ctx).push(
        MaterialPageRoute(
            builder: (_){
              return PicsScreen();
            }
        )
    );
  }

  void selectAgendaPage(BuildContext ctx){
    Navigator.of(ctx).push(
        MaterialPageRoute(
            builder: (_){
              return ScheduleScreen();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () => selectFigurasPage(context) ,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: AssetImage(
                          'resources/picsButton.png',
                        ),
                        width: 150,
                        height: 150,
                      ),
                      Text(
                          'Figuras',
                          style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic)
                      )
                    ]
                )
            ),
            SizedBox(height: 50),
            InkWell(
                onTap: () => selectAgendaPage(context) ,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: AssetImage(
                          'resources/schedule.png',
                        ),
                        width: 150,
                        height: 150,
                      ),
                      Text(
                          'Agenda',
                          style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic)
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}
