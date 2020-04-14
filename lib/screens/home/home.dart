import 'package:flutter/material.dart';
import 'package:resturantapp/screens/allOrders/allOrders.dart';
import 'package:resturantapp/screens/home/widgets/messBody/messBody.dart';
import 'package:resturantapp/screens/home/widgets/orderBody/orderBody.dart';

class Home extends StatefulWidget {

  int currentBody = 0;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
            resizeToAvoidBottomPadding: false,
           appBar: AppBar(
             automaticallyImplyLeading: false,
             backgroundColor: Colors.white,
             elevation: 0,
             bottom: _getTabBar(),
             actions: <Widget>[
               IconButton(
                 icon: Icon(
                     Icons.shopping_cart,
                 ),
                 color: Colors.teal,
                 iconSize: 30,
                 onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllOrders())),
               )
             ],
           ),
        body: _getBody(),
      ),
    );
  }




  Widget _getTabBar(){
    return TabBar(
      unselectedLabelColor: Colors.amberAccent,
      indicatorSize: TabBarIndicatorSize.label,
      onTap: (int a){
        setState(() {
          widget.currentBody = a;
        });
      },
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber
      ),
      tabs: <Widget>[
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.amberAccent, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("Order"),
            ),
          ),
        ),
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.amberAccent, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("Mess"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getBody() {
    return (widget.currentBody == 0) ? OrderBody() : MessBody();
  }
}
