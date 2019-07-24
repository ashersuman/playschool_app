import 'package:flutter/material.dart';

import '../utils/routes.dart';
import 'kid_form.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key:key);

   static Route<dynamic> route() {
    return SimpleRoute(
      name: '/homepage',
      title: 'Welcome to FunSchool',
      builder: (_) => HomePage(),
    );
  }  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("FunSchool"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                child: Icon(Icons.exit_to_app,),
                onTap: () {
                  //AuthManager().signOut();
                  // Doing Pop and Push for the smooth closing animation
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            )
          ],
        ),
        body: Container(
//          color: Colors.green,
          child: Center(
            child: Text(
              'Welcome to FunSchool',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ),
        floatingActionButton: SizedBox(
          width: 80.0,
          height: 80.0,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed("/register-parent");
            },
            child: Icon(
              Icons.add,
              size: 45.0,
            ),
            backgroundColor: Colors.pink,
          ),
        ),
    );
  }
}