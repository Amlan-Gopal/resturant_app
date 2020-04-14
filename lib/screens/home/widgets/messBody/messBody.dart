import 'package:flutter/material.dart';
import 'package:resturantapp/service/messAPIService.dart';

class MessBody extends StatefulWidget {

  List messList = List();

  @override
  _MessBodyState createState() => _MessBodyState();
}

class _MessBodyState extends State<MessBody> {

  MessAPIService _messAPIService = new MessAPIService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMessData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: ((widget.messList == null || widget.messList.isEmpty) ? 0 : widget.messList.length),
            itemBuilder: (BuildContext context, int index){
              return Text('${widget.messList[index]}');
            }
        ),
      ),
    );
  }

  void _setMessData(){
    _messAPIService.getAllMessCustomers().then((list) =>
        setState(() {
          widget.messList = list;
        })
    );
  }
}
