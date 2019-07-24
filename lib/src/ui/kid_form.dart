import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import '../blocs/kid_bloc.dart';
import '../utils/routes.dart';
import '../utils/datePickerWidget.dart';

class RegisterChildForm extends StatefulWidget {
  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/register-child',
      title: 'Sign Up-FunSchool',
      builder: (_) => RegisterChildForm(),
    );
  }

  @override
  _RegisterChildFormState createState() => _RegisterChildFormState();
}

class _RegisterChildFormState extends State<RegisterChildForm> {
  String childFirstName = '';
  int _adhaarAvailable;
  int _sexValue;
  final _adhaarTextInputFormatter _adhaarNumberFormatter =
      _adhaarTextInputFormatter();
  final List<String> _allRelations = <String>[
    'Father',
    'Mother',
    'Legal Guardian'
  ];
  String _relation;

  DateTime _fromDate = DateTime.now();

  String _inviteLabel;

  @override
  void initState() {
    super.initState();
    _adhaarAvailable = null;
    _sexValue = null;
    _relation = null;
    _inviteLabel = null;
  }

  @override
  void dispose(){
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
          margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
          child: childForm(),
        ),
      ),
    );
  }

  Widget childForm() {
    return Form(
      child: Scrollbar(
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Container(margin: EdgeInsets.all(5.0)),
              firstName(),
              SizedBox(
                height: 8.0,
              ),
              lastName(),
              SizedBox(
                height: 8.0,
              ),
              relationShip(),
              SizedBox(
                height: 15.0,
              ),
              adhaarCheck(),
              SizedBox(
                height: 15.0,
              ),
              adhaarNum(_adhaarAvailable),
              otp(_adhaarAvailable),
              dateOfBirth(),
              SizedBox(
                height: 15.0,
              ),
              sex(),
              SizedBox(
                height: 15.0,
              ),
              nickName(),
              SizedBox(
                height: 15.0,
              ),
              schoolName(),
              SizedBox(
                height: 15.0,
              ),
              registerButton(),
              Divider(
                color: Colors.blueGrey,
              ),
              inviteLabel(),
              inviteGuardian(),
              SizedBox(
                height: 10.0,
              ),
              inviteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstName() {
    return StreamBuilder(
      stream: kidBloc.fname,
      builder: (context, snapshot) {
        return TextField(
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: childFirstName != '' ? 'So cute!' : 'Child\'s Firstname',
            errorText: snapshot.error,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          onChanged:(text) {
            //kidBloc.fchangeName();
            setState(() {
              childFirstName = text;
            });
          },
        );
      }
    );
  }
  Widget lastName() {
    return StreamBuilder(
      stream: kidBloc.lname,
      builder: (context, snapshot) {
        return TextField(
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: childFirstName != ''
                ? childFirstName + '\'s Lastname'
                : 'Child\'s Lastname',
            errorText: snapshot.error,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: kidBloc.lchangeName,
        );
      }
    );
  }

  Widget relationShip() {
    return DropdownButtonFormField<String>(
      items: _allRelations.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _relation != null ? _relation : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        labelText: childFirstName != ''
            ? 'Your relation with ' + childFirstName
            : 'Your relation with child',
        errorText: _relation == null ? 'Please choose your relation with' + childFirstName : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      onChanged: (String newValue) {
        setState(() {
          _relation = newValue;
        });
      },
    );
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
          childFirstName != ''
              ? 'Does ' + childFirstName + ' have Aadhaar number ?'
              : 'Does child have Aadhaar number ?',
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

  Widget adhaarNum(int status) {
    if (status == 0) {
      return TextField(
        keyboardType: TextInputType.phone,
        //maxLength: 14,
        //maxLengthEnforced: true,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(12),
          // Fit the validating format.
          _adhaarNumberFormatter,
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          labelText: childFirstName != ''
              ? childFirstName + '\'s Aadhaar number'
              : 'Child\'s Aadhaar number',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget otp(int status) {
    if (status == 0) {
      return Padding(
        padding: const EdgeInsets.only(top:8.0,left:8.0,right:8.0,bottom:15.0),
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: 'OTP',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget dateOfBirth() {
    return DateTimePicker(
      labelText: childFirstName != ''
          ? childFirstName + '\'s Birth Date'
          : 'Child\'s Birth Date',
      selectedDate: _fromDate,
      selectDate: (DateTime date) {
        setState(() {
          print(date);
          _fromDate = date;
        });
      },
    );
  }

  Widget sex() {
    //Setting state for radio button
    setSelectedRadio(val) {
      setState(() {
        _sexValue = val;
      });
    }

    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          childFirstName != '' ? childFirstName + ' is' : 'Child is',
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: _sexValue,
              activeColor: Colors.blue,
              onChanged: (val) {
                print("Boy");
                setSelectedRadio(val);
              },
            ),
            Text('Boy'),
            Radio(
              value: 1,
              groupValue: _sexValue,
              activeColor: Colors.blue,
              onChanged: (val) {
                print("Girl");
                setSelectedRadio(val);
              },
            ),
            Text('Girl'),
          ],
        ),
      ],
    );
  }

  Widget nickName() {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          labelText: childFirstName != ''
              ? childFirstName + '\'s nickname'
              : 'Child\'s nickname',
          border: OutlineInputBorder(
            borderSide: BorderSide(
            color: Colors.blue,
          ),
        )
      ),
    );
  }

  Widget schoolName() {
    return StreamBuilder(
      stream: kidBloc.sname,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            labelText: childFirstName != ''
                ? childFirstName + '\'s school name'
                : 'Child\'s school name',
            errorText: snapshot.error,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue,
              ),
            )
          ),
          onChanged: kidBloc.schangeName,
        );
      }
    );
  }

  Widget inviteGuardian(){
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          //labelText: _inviteLabel(),
          hintText: "gaurdian@example.com",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          )
      ),
    );
  }

/*  childFirstName != ''
  ? _relation == ''childFirstName + '\'s' + +'to handle profile along with you.'
      : 'Invite Child\'s Guardian to handle profile along with you.',*/

  Widget inviteLabel() {
    String label = '';
    if(childFirstName!= ''){
      switch(_relation){
        case "Father":
          label = 'Invite '+ childFirstName +'\'s ' +_allRelations[1]+'/ '+ _allRelations[2] + ' to handle profile along with you.';
          break;
        case "Mother":
          label = 'Invite '+ childFirstName +'\'s ' +_allRelations[0]+'/ '+ _allRelations[2] + ' to handle profile along with you.';
          break;
        default:
          label = 'Invite '+ childFirstName +'\'s ' +_allRelations[0]+'/ '+ _allRelations[1] + ' to handle profile along with you.';
      }
    }
    else{
       label = 'Invite Child\'s Guardian to handle profile along with you.';
    }

    setState(() {
      _inviteLabel = label;
    });

    return Padding(
      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
      child: Text(
        _inviteLabel,
        style: TextStyle(
          fontSize: 16.0
        ),
      ),
    );
  }

  Widget registerButton(){
    return RaisedButton(
      onPressed: (){},
      child: Text(
        'Register',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0
        ),
      ),
      color: Colors.green,
    );
  }

  Widget inviteButton(){
    return RaisedButton(
      onPressed: (){},
      child: Text(
        'Invite',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0
        ),
      ),
      color: Colors.purple,
    );
  }

  /*bool _autoValidate(){
    if(_adhaarAvailable != null && _sexValue != null && _relation != null){
      return true;
    }
    else{
      return false;
    }
  }*/
}

//TEXT INPUT FORMATTER
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
