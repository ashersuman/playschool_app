import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'sign-up.dart';

import '../utils/routes.dart';
import '../blocs/login_bloc.dart';
import '../blocs/login_provider.dart';

class LoginPage extends StatefulWidget {
  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/login',
      title: 'Log In - FunSchool',
      builder: (_) => LoginPage(),
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginProvider.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFfac555),
      body: LoginForm(loginBloc),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginBloc bloc;
  LoginForm(this.bloc);

  Widget emailField() {
    return StreamBuilder<String>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          //initialValue: 'someone@example.com',
          decoration: InputDecoration(
            hintText: 'Email/ Mobile No.',
            errorText: snapshot.error,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
          onChanged: bloc.changeEmail,
          //onSubmitted: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder<String>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          autofocus: false,
          //initialValue: 'Password',
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: snapshot.error,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorStyle: TextStyle(

            ),
          ),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget buttonRow(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: StreamBuilder(
            stream: bloc.submitValid,
            builder: (context, snapshot) {
              return RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                //disabledColor: Colors.indigo,
                onPressed: !snapshot.hasData
                    ? null
                    : () {
                        bloc.submit();
                        Navigator.of(context).pushReplacement(HomePage.route());
                      },
                //Navigator.of(context).pushNamed(HomePage.tag);

                padding: EdgeInsets.all(12),
                color: Colors.indigo,
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(SignUpPage.route());
            },
            padding: EdgeInsets.all(12),
            color: Colors.black,
            child: Text(
              'Sign Up',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }

  Widget forgotLabel() {
    return FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black87),
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: 400.0,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            emailField(),
            SizedBox(
              height: 10.0,
            ),
            passwordField(),
            SizedBox(
              height: 24.0,
            ),
            buttonRow(context),
            SizedBox(
              height: 2.0,
            ),
            forgotLabel(),
          ],
        ),
      ),
    );
  }
}
