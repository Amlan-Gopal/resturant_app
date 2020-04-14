import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resturantapp/model/order/item.dart';
import 'package:resturantapp/model/order/order.dart';
import 'package:resturantapp/screens/allOrders/allOrders.dart';
import 'package:resturantapp/screens/home/home.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {

  Order order;
  bool enableBack;
  OrderDetails({Key key, this.order, this.enableBack}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.enableBack,
        title: Text('Order Details'),
        actions: <Widget>[
          _getHomeOrderLinks(),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
            child: Container(
              child: Card(
              elevation: 3,
              color: Colors.tealAccent,
              margin: EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                      child: _getTopSideWidget()
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: _getMiddleSideWidget()
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: _getBottomSideWidget()
                  )
                ],
              ),
         ),
        ),
     ),
      )
    );
  }

  Widget _getHomeOrderLinks(){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.teal,
            iconSize: 30,
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.teal,
            iconSize: 30,
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllOrders())),
          ),
        ],
      ),
    );
   }

   Widget _getTopSideWidget(){
     var formatter = new DateFormat('dd-MM-yyyy');
     String orderDate = formatter.format(widget.order.orderDate);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Order ID : ${widget.order.orderId}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Customer Name : ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _NameAsList(name: widget.order.customerName, isCustomer: true)
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
              'Date : $orderDate',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04
            ),
          ),
        ],
      );
   }

   Widget _getMiddleSideWidget(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Items :',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getItemList(),
              ),
            )
          ],
        ),
      ),
    );
   }
  Widget _getBottomSideWidget(){
    return Container(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Total Price',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
            Text('Rs. ${widget.order.totalPrice} /-',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.035,
              ),
            )
          ],
        ),
      ),
    );
    }

  List<Widget> _NameAsList({String name, bool isCustomer}){
    List<Widget> widgetList = [];
    List<String> words = (name != null) ? name.split(" ") : [];
    words.forEach((word) =>
        widgetList.add(
            Text(
                '$word',
              style: TextStyle(
                  fontSize: (isCustomer) ? MediaQuery.of(context).size.width * 0.06 : MediaQuery.of(context).size.width * 0.04
              ),
            )
        )
    );
    return widgetList;
  }

  List<Widget> _getItemList(){
    List<Widget> widgetList = [];
    for(Item item in widget.order.items){
      widgetList.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  '${item.count}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _NameAsList(name: item.itemName, isCustomer: false),
              ),
              Text(
                '${item.price/ item.count} * ${item.count} = ${item.price}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04
                ),
              )
            ],
          ),
        )
      );
    }
    return widgetList;
  }
  }


