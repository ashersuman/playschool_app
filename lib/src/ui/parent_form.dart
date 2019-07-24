import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/routes.dart';
import '../blocs/parent_bloc.dart';

class RegisterParentForm extends StatefulWidget {

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/register-child',
      title: 'Sign Up-FunSchool',
      builder: (_) => RegisterParentForm(),
    );
  }

  @override
  _RegisterParentFormState createState() => _RegisterParentFormState();
}

class _RegisterParentFormState extends State<RegisterParentForm> {
  int _adhaarAvailable;
  final _adhaarTextInputFormatter _adhaarNumberFormatter = _adhaarTextInputFormatter();

  static final TextEditingController _initialFirstName = TextEditingController();
  static final TextEditingController _initialLastName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _adhaarAvailable = null;
    _initialFirstName.text = "AadhaarFirstName";
    _initialLastName.text = "AadhaarLastName";
  }

  @override
  void dispose(){
    parentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              "Registration"
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left:10.0,top:10.0,right:10.0,bottom:5.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  adhaarCheck(),
                  parentForm(_adhaarAvailable),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget parentForm(_adhaarAvailable) {
    if (_adhaarAvailable == 0){
      return Column(
        children: <Widget>[
          Container(margin: EdgeInsets.all(5.0)),
          adhaarNumber(),
          SizedBox(
            height: 15.0,
          ),
          otp(),
          SizedBox(
            height: 15.0,
          ),
          firstName(),
          SizedBox(
            height: 15.0,
          ),
          lastName(),
          SizedBox(
            height: 15.0,
          ),
          emailID(),
          SizedBox(
            height: 15.0,
          ),
          adhaarEmailID(),
          SizedBox(
            height: 15.0,
          ),
          mobileNumber(),
          SizedBox(
            height: 15.0,
          ),
          adhaarMobileNumber(),
          SizedBox(
            height: 15.0,
          ),
          submit()
        ],
      );
    }
    else
      if(_adhaarAvailable == 1){
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.black,
            margin: EdgeInsets.only(top:25.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 60.0,
                        ),
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 60.0,
                        ),
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 60.0,
                        ),
                      ],
                    ),
                    Text(
                      'Kindly get yor aadhaar first.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      else{
        return Container(
          margin: EdgeInsets.all(0.0),
        );
      }

  }

  Widget adhaarCheck() {
    //Setting state for radio button
    setSelectedRadio(val) {
      setState(() {
        _adhaarAvailable = val;
      });
    }

    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Do you have Aadhaar ?',
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: _adhaarAvailable,
              activeColor: Colors.green,
              onChanged: (val) {
                print("Aadhaar Available");
                setSelectedRadio(val);
              },
            ),
            Text('Yes'),
            Radio(
              value: 1,
              groupValue: _adhaarAvailable,
              activeColor: Colors.red,
              onChanged: (val) {
                print("Aadhaar Not Available");
                setSelectedRadio(val);
              },
            ),
            Text('No'),
          ],
        ),
      ],
    );
  }

  Widget adhaarNumber(){
    return StreamBuilder(
      stream: parentBloc.aadhaar,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
            // Fit the validating format.
            _adhaarNumberFormatter,
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: 'Your Aadhaar number',
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue
              ),
            ),
          ),
          onChanged: parentBloc.changeAadhaar,
        );
      }
    );
  }

  Widget otp(){
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left:8.0,right:8.0,bottom:15.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          labelText: 'Enter the OTP',
          hintText: 'Check your registered mobile number',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue
            ),
          ),
        ),
      ),
    );
  }

  Widget firstName(){
    return StreamBuilder(
      stream: parentBloc.fname,
      builder: (context, snapshot) {
        return TextField(
          controller: _initialFirstName,
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: 'Firstname',
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: parentBloc.fchangeName,
        );
      }
    );
  }

  Widget lastName(){
    return StreamBuilder<Object>(
      stream: parentBloc.lname,
      builder: (context, snapshot) {
        return TextField(
          controller: _initialLastName,
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: 'Lastname',
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: parentBloc.lchangeName,
        );
      }
    );
  }

  Widget emailID(){
    return TextField(
      controller: TextEditingController()..text = 'LoginEmail@example.com',
      enabled: false,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        labelText: 'Email ID',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      //readOnly: true,
    );
  }

  Widget adhaarEmailID(){
    return TextFormField(
      initialValue: 'AadhaarEmail@example.com',
      autocorrect: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        labelText: 'Aadhaar Linked Email ID',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget mobileNumber(){
    return TextField(
      controller: TextEditingController()..text = '88888 88999',
      autocorrect: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        labelText: 'Mobile Number',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget adhaarMobileNumber(){
    return TextField(
      controller: TextEditingController()..text = '99999 00000',
      autocorrect: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        labelText: 'Aadhaar Linked Mobile Number',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
  Widget submit(){
    return StreamBuilder(
      stream: parentBloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed:
            //Navigator.of(context).pushNamed("/register-child");
            (snapshot.hasData)
                ?(){
              parentBloc.submit();
              Navigator.of(context).pushNamed("/register-child");
            }
            : null,
          child: Text(
            'Next',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
            ),
          ),
          color: Colors.green,
        );
      }
    );
  }
}

class _adhaarTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 4) + ' ');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= 10) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 8) + ' ');
      if (newValue.selection.end >= 8) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

