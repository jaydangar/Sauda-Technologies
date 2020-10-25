import 'package:flutter/material.dart';
import 'package:game/home/ui/homepage.dart';
import 'package:game/login/ui/login.dart';

class Routing {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        final _user = settings.arguments;
        return MaterialPageRoute(builder: (context) => HomePage(_user));
        break;
      case loginRoute:
        return MaterialPageRoute(builder: (context) => LogInPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => LogInPage());
        break;
    }
  }
}
