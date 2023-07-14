import 'package:flutter/cupertino.dart';
import 'package:pecs_app/myapp.dart';
import 'package:pecs_app/pages/schedule/schedule_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home' : (_) => const HomePage(),
    '/schedule': (_)  => ScheduleScreen(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}