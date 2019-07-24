import 'package:flutter/material.dart';
import 'signup_bloc.dart';

class SignUpProvider extends InheritedWidget {
  final bloc = SignUpBloc();

  SignUpProvider({Key key, Widget child})
      : super(key: key, child:child);

  bool updateShouldNotify(_) => true;

  static SignUpBloc of(BuildContext context) {
    return(context.inheritFromWidgetOfExactType(SignUpProvider) as SignUpProvider).bloc;
  }
}