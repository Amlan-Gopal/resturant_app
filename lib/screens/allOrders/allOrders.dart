import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:resturantapp/model/order/order.dart';
import 'package:resturantapp/screens/home/home.dart';
import 'package:resturantapp/screens/orderDetails/orderDetails.dart';
import 'package:resturantapp/service/orderAPIService.dart';

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  OrderAPIService _orderAPIService = OrderAPIService();
  List<Order> orders = List<Order>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('All Orders'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            color: Colors.teal,
            iconSize: 30,
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
          )
        ],
      ),
      body: SafeArea(
        top: true,
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: ((orders == null || orders.isEmpty) ? 0 : orders.length),
            itemBuilder: (BuildContext context, int index){
              return _getItemCard(index);
            }
        ),
      ),
    );
  }

  Widget _getItemCard(int index){
    var formatter = new DateFormat('dd-MM-yyyy');
    String orderDate = formatter.format(orders[index].orderDate);
    return Card(
      color: Colors.white70,
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Order ID : ${orders[index].orderId}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06
                  ),
                ),
                Text(
                  'Date : $orderDate',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05
                  ),
                )
              ],
            ),
            Text(
              'Customer Name : ${orders[index].customerName}',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                    Text('Rs. ${orders[index].totalPrice} /-',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                      ),
                    )
                  ],
                ),
                FlatButton(
                  child: Text('Details'),
                  color: Colors.amberAccent,
                  padding: EdgeInsets.all(5),
                  highlightColor: Colors.amber,
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => Home()
                    ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  _initializeOrders() async{
    await _orderAPIService.getAllOrders().then((list) {
      if(list != null && list.isNotEmpty){
        setState(() {
          orders = list;
        });
      }
    });
  }
}
