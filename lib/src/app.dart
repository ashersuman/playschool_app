import 'package:flutter/material.dart';

import 'blocs/login_provider.dart';

import 'ui/sign-up.dart';
import 'ui/home_page.dart';
import 'ui/login_page.dart';
import 'ui/kid_form.dart';
import 'ui/parent_form.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "GoogleSansRegular",
        ),
        home: LoginPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch(settings.name) {
            case "/login": return LoginPage.route();
            case "/homepage": return HomePage.route();
            case "/sign-up": return SignUpPage.route();
            case "/register-child" : return RegisterChildForm.route();
            case "/register-parent" : return RegisterParentForm.route();
            default: return LoginPage.route();
          }
        },
      ),
    );
  }
}