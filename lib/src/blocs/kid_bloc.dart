import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'validationMixin.dart' show NameValidator,AadhaarValidator;

class KidRegisterBloc extends Object with NameValidator,AadhaarValidator{
  final _aadhaarController = BehaviorSubject<String>();
  final _firstnameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _schoolnameController = BehaviorSubject<String>();

  //GETTERS
  //Input
  Function(String) get changeAadhaar => _aadhaarController.sink.add;
  ///first name change
  Function(String) get fchangeName => _firstnameController.sink.add;
  ///last name change
  Function(String) get lchangeName => _lastnameController.sink.add;
  ///Child School Name
  Function(String) get schangeName => _schoolnameController.sink.add;

  //Validators
  Stream<String> get aadhaar =>
      _aadhaarController.stream.transform(validateAadhaarNumber);
  Stream <String> get fname => _firstnameController.stream.transform(validateName);
  Stream <String> get lname => _lastnameController.stream.transform(validateName);
  Stream <String> get sname => _schoolnameController.stream.transform(validateName);


  //Submit Valid form with Aadhaar
  Stream<bool> get submitValidwithAadhaar => Observable.combineLatest4(aadhaar, fname, lname, sname, (a,f,l,s) => true);

  //Submit Valid form without Aadhaar
  Stream<bool> get submitValidwithoutAadhaar => Observable.combineLatest3(fname, lname, sname, (f,l,s) => true);


  //SUBMIT method
  submit(){
    final validAadhaar = _aadhaarController.value;
    final validFirstName = _firstnameController.value;
    final validLastName = _lastnameController.value;
    print('Aadhaar is $validAadhaar');
    print('Name is $validFirstName');
    print('Name is $validLastName');
  }


  //Dispose Streams
  dispose(){
    _aadhaarController.close();
    _firstnameController.close();
    _lastnameController.close();
    _schoolnameController.close();
  }
}

final kidBloc = KidRegisterBloc();