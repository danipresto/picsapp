import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pecs_app/services/admin_mode_provider.dart'; // Import the AdminModeProvider
import 'package:pecs_app/services/notifications_services.dart';
import 'package:pecs_app/services/schedule_list_provider.dart';
import 'package:pecs_app/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        ChangeNotifierProvider<ScheduleListProvider>(
          create: (context) => ScheduleListProvider(),
        ),
        ChangeNotifierProvider<AdminModeProvider>(
          create: (context) => AdminModeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PECS App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0xFFE0F2F1), // Cor verde suave
        fontFamily: 'Lexend',
      ),
      home: const HomePage(),
    );
  }
}

