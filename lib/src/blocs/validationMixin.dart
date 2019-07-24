import 'dart:async';

//Validation Rules
const String _EmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
const String _PasswordRule = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$";
const String _NameRule = r"^[a-zA-Z]+$";


//Validation Fail Errors
const String _emailError = 'Enter a valid Email';
const String _passwordError = 'Password must be at least 8 characters\n '
    'and must include at least one upper case letter,\n one lower case letter, and one numeric digit.';
const String _nameError = 'Error 404 : Name not Found';
const String _mobNumError = 'Enter a valid Mobile Number';
const String _aadhaarNumError = 'Enter a valid Aadhaar Number';

// Validators
class EmailValidator {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {

        final RegExp emailExp = RegExp(_EmailRule);

        if (!emailExp.hasMatch(email) || email.isEmpty) {
          sink.addError(_emailError);
        } else {
          sink.add(email);
        }
      }
  );
}

class PasswordValidator {
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {

        final RegExp passExp = RegExp(_PasswordRule);

        if (passExp.hasMatch(password)) {
          sink.add(password);
        } else {
          sink.addError(_passwordError);
        }
      }
  );
}

class NameValidator{
  final validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink){

        final RegExp nameExp = RegExp(_NameRule);

        if(nameExp.hasMatch(name)){
          sink.add(name);
        }else{
          sink.addError(_nameError);
        }
      }
  );
}

class MobileNumValidator{
  final validateMobileNum = StreamTransformer<String, String>.fromHandlers(
    handleData: (mobile, sink){
      if(mobile.length >= 10){
        sink.add(mobile);
      }else{
        sink.addError(_mobNumError);
      }
    }
  );
}

class AadhaarValidator{
  final validateAadhaarNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (aadhaar, sink){
      if(aadhaar.split(" ").join("").length == 12){
        sink.add(aadhaar);
      } else {
        sink.addError(_aadhaarNumError);
      }
    }
  );
}