import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'validationMixin.dart' show NameValidator,AadhaarValidator;

class ParentBloc extends Object with NameValidator,AadhaarValidator{
  final _aadhaarController = BehaviorSubject<String>();
  final _firstnameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();

  //GETTERS
  //Input
  Function(String) get changeAadhaar => _aadhaarController.sink.add;
  ///first name change
  Function(String) get fchangeName => _firstnameController.sink.add;
  ///last name change
  Function(String) get lchangeName => _lastnameController.sink.add;
  //Validators
  Stream<String> get aadhaar =>
      _aadhaarController.stream.transform(validateAadhaarNumber);

  Stream <String> get fname => _firstnameController.stream.transform(validateName);

  Stream <String> get lname => _lastnameController.stream.transform(validateName);


  //Submit Valid form
  Stream<bool> get submitValid => Observable.combineLatest3(aadhaar, fname, lname, (a,f,l) => true);


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
  }
}

final parentBloc = ParentBloc();