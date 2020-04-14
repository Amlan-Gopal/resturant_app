import 'dart:async';

import 'package:flutter/material.dart';

import 'home/home.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate(Home());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      alignment: AlignmentDirectional.center,
      child: Image(
        image: AssetImage("assets/images/welcome.png"),
        fit: BoxFit.fill,
      ),
    );
  }

  _navigate(Widget destination){
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => destination
      ));
    });
  }
}

