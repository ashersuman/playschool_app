import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validationMixin.dart' show EmailValidator,PasswordValidator;

class LoginBloc extends Object with EmailValidator,PasswordValidator{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //GETTERS

  //
  //INPUT
  //
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //
  // Validators
  //
  Stream<String> get email =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //LOGIN BUTTON
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);
  

  //SUBMIT method
  submit(){
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  //Sink close
  dispose(){
    _emailController.close();
    _passwordController.close();
  }
}

// SINGLE INSTANCE OF BLOC
//final bloc = Bloc();