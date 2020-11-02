import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './views/homeView.dart';
import './views/imgselection.dart';
import './views/login_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/imgselection':
        return MaterialPageRoute(builder: (_) => pick_image());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
