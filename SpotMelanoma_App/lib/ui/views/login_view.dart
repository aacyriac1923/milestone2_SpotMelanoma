import 'package:flutter/material.dart';
import 'package:spotmelanoma/core/enum/viewstate.dart';
import 'package:spotmelanoma/core/viewmodels/login_model.dart';
import 'package:spotmelanoma/ui/shared/app_colors.dart';
import 'package:spotmelanoma/ui/widgets/login_header.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(
                validationMessage: model.errorMessage, controller: _controller),
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : FlatButton(
                    color: Colors.orange,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: () async {
                      var loginSuccess = await model.login(_controller.text);
                      if (loginSuccess) {
                        Navigator.pushNamed(context, '/');
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}
