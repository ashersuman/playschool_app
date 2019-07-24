import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pin_view/pin_view.dart';

//import '../blocs/signup_provider.dart';
import '../blocs/signup_bloc.dart';
import '../utils/routes.dart';

class SignUpPage extends StatefulWidget {
  //const SignUpPage({Key key}) : super(key:key);

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/sign-up',
      title: 'Sign Up-FunSchool',
      builder: (_) => SignUpPage(),
    );
  }

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Unsaved data will be lost.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (_) => false),
                child: new Text('Yes'),
              ),
            ],
          );
          //) ?? false;
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFFfac555),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();
  }

  Widget emailField() {
    return StreamBuilder(
      stream: _signUpBloc.email,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          //initialValue: 'someone@example.com',
          decoration: InputDecoration(
            hintText: 'Email',
            errorText: snapshot.error,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
          onChanged: _signUpBloc.onEmailChange,
        );
      }
    );
  }

  final emailOTP = TextFormField(
    cursorColor: Colors.black,
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    //initialValue: 'someone@example.com',
    decoration: InputDecoration(
      hintText: 'Enter OTP sent to Email',
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );

  Widget mobNumField() {
    return StreamBuilder(
      stream: _signUpBloc.mobileNum,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          maxLength: 10,
          //initialValue: 'someone@example.com',
          decoration: InputDecoration(
            hintText: 'Mobile Number',
            errorText: snapshot.error,
            counterText:'',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
          onChanged: _signUpBloc.onMobileNumChange,
        );
      }
    );
  }

  final mobOTP = TextFormField(
    cursorColor: Colors.black,
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    //initialValue: 'someone@example.com',
    decoration: InputDecoration(
      hintText: 'Enter OTP sent to Mobile',
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );

  Widget mobileOTP(context) {
    /*return SizedBox(
        child: PinPut(
          fieldsCount: 6,
          onSubmit: (String value) {
            print(value);
          },
          //spaceBetween: ,
          textStyle: TextStyle(fontSize: 18.0),
          containerHeight: 60.0,
          clearInput: true,
          actionButtonsEnabled: false,
          inputDecoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ));*/
      return PinView(

      );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: _signUpBloc.password,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          autofocus: false,
          //initialValue: 'Password',
          //obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: snapshot.error,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: _signUpBloc.onPasswordChange,
        );
      }
    );
  }

  Widget cnfPasswordField() {
    return StreamBuilder(
      stream: _signUpBloc.cnfPassword,
      builder: (context, snapshot) {
        return TextField(
          cursorColor: Colors.black,
          autofocus: false,
          //initialValue: 'Password',
          //obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            errorText: snapshot.error,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: _signUpBloc.onCnfPasswordChange,
        );
      }
    );
  }

  Widget submitButton(context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: StreamBuilder(
          stream: _signUpBloc.signupValid,
          builder: (context, snapshot) {
            return RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: /*() {
                //Navigator.of(context).pushNamed(HomePage.tag);
                Navigator.of(context).pop();
              },*/
              (snapshot.hasData)
                  ? () {
                _signUpBloc.submit();
              }
                  : null,
              padding: EdgeInsets.all(12),
              color: Colors.indigo,
              child: Text(
                'Sign Up!',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        ),
      );

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: 400.0,
        child: Scrollbar(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              /*shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),*/
              children: <Widget>[
                Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40.0,
                ),
                emailField(),
                SizedBox(
                  height: 10.0,
                ),
                emailOTP,
                SizedBox(
                  height: 10.0,
                ),
                mobNumField(),
                SizedBox(
                  height: 10.0,
                ),
                mobOTP,
                SizedBox(
                  height: 10.0,
                ),
                passwordField(),
                SizedBox(
                  height: 10.0,
                ),
                cnfPasswordField(),
                SizedBox(
                  height: 24.0,
                ),
                // loginButton,
                // SizedBox(height: 2.0,),
                // signupButton,
                SizedBox(
                  height: 2.0,
                ),
                submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
