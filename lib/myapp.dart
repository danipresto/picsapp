import 'package:flutter/material.dart';
import 'package:pecs_app/pages/pecs/pics_screen.dart';
import 'package:pecs_app/pages/schedule/schedule_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void selectFigurasPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return PicsScreen();
        },
      ),
    );
  }

  void selectAgendaPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ScheduleScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMenuButton(
              context,
              'resources/picsButton.png',
              'Figuras',
              selectFigurasPage,
            ),
            const SizedBox(height: 50),
            _buildMenuButton(
              context,
              'resources/schedule.png',
              'Agenda',
              selectAgendaPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String imagePath, String label, Function(BuildContext) onTap) {
    return InkWell(
      onTap: () => onTap(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink.image(
            image: AssetImage(imagePath),
            width: 150,
            height: 150,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
