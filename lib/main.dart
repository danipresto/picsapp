import 'package:flutter/material.dart';
import 'package:pecs_app/support/notifications_services.dart';
import 'package:provider/provider.dart';
import 'myapp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
      ],
      child: MaterialApp(
          home: const HomePage()
      ),
    ),
  );

}

