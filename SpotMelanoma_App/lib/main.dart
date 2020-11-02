import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmelanoma/core/services/authentication_service.dart';
import 'package:spotmelanoma/locator.dart';
import 'package:spotmelanoma/ui/router.dart';

import 'core/models/user.dart';
import 'core/viewmodels/CRUDModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
        StreamProvider<User>(
            builder: (_) =>
                locator<AuthenticationService>().userController.stream,
            initialData: User.initial()),
      ],
      child: MaterialApp(
        title: 'Spot Melanoma',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

