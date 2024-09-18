import 'package:flutter/material.dart';
import 'package:pecs_app/pages/pecs/pics_screen.dart';
import 'package:pecs_app/pages/schedule/schedule_screen.dart';
import 'package:pecs_app/pages/settings.dart';
import 'package:pecs_app/widgets/custom_app_bar.dart'; // Import the settings page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void selectPecsPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => PicsScreen(),
      ),
    );
  }

  void selectAgendaPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => ScheduleScreen(),
      ),
    );
  }

  void openSettingsPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'PECS Speak',
      ),
      backgroundColor: const Color(0xFFFFF9C4), // Amarelo pastel brilhante
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100, // Defina a altura do DrawerHeader aqui
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                margin: EdgeInsets.zero, // Remove a margem padrão
                padding: EdgeInsets.zero, // Remove o padding padrão
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'PECS',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                ),
              ),
              onTap: () => selectPecsPage(context),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text(
                'Agenda',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                ),
              ),
              onTap: () => selectAgendaPage(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Configurações',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                ),
              ),
              onTap: () => openSettingsPage(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMenuButton(
              context,
              'resources/picsButton.png',
              'PECS',
              selectPecsPage,
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

  Widget _buildMenuButton(
      BuildContext context,
      String imagePath,
      String label,
      Function(BuildContext) onTap,
      ) {
    return InkWell(
      onTap: () => onTap(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Ink.image(
                image: AssetImage(imagePath),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
