import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validationMixin.dart' show PasswordValidator,EmailValidator,MobileNumValidator;

class SignUpBloc extends Object with EmailValidator,PasswordValidator,MobileNumValidator{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cnfPasswordController = BehaviorSubject<String>();
  final _mobileNumController = BehaviorSubject<String>();
  //INPUTS
  Function(String) get onEmailChange => _emailController.sink.add;
  Function(String) get onPasswordChange => _passwordController.sink.add;
  Function(String) get onCnfPasswordChange => _cnfPasswordController.sink.add;
  Function(String) get onMobileNumChange => _mobileNumController.sink.add;

  //VALIDATORS
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get cnfPassword => _cnfPasswordController.stream.transform(validatePassword)
      .doOnData((String cnfPass){
      if(0 != _passwordController.value.compareTo(cnfPass)){
        _cnfPasswordController.addError('Password doesn\'t match');
      }
  });
  Stream<String> get mobileNum => _mobileNumController.stream.transform(validateMobileNum);

  //SIGN UP BUTTON
  Stream<bool> get signupValid => Observable.combineLatest4(email, password, cnfPassword, mobileNum, (e,p,c,m) => true);

  //SIGN UP METHOD
  submit(){
    final validEmail = _emailController.value;
    final validPassword = _cnfPasswordController.value;

    print('Email used to SignUp is $validEmail');
    print('Password registered at SignUp is $validPassword');
  }

  dispose(){
   _emailController?.close();
   _passwordController?.close();
   _cnfPasswordController?.close();
   _mobileNumController?.close();
  }
}