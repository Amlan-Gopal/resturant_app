import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:resturantapp/model/order/item.dart';
import 'package:resturantapp/model/order/menu.dart';
import 'package:resturantapp/model/order/order.dart';
import 'package:resturantapp/screens/orderDetails/orderDetails.dart';
import 'package:resturantapp/service/orderAPIService.dart';

// ignore: must_be_immutable
class OrderBody extends StatefulWidget {

  List<Menu> menuList  = List<Menu>();
  Order order = Order();
  List<Item> items = List<Item>();

  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {

  OrderAPIService _orderAPIService = new OrderAPIService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeOrder();
    _setMenuList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: _getWidgetForMenuList(),

      )
    );
  }

  Widget _getWidgetForMenuList(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: _getListView(),
        ),
        _getBottomArea(),
      ],
    );
  }

  Widget _getListView(){
    return ListView.builder(
        itemCount: ((widget.menuList == null || widget.menuList.isEmpty) ? 0 : widget.menuList.length),
        itemBuilder: (BuildContext context, int index) {
          return _getMenuCard(index) ;
        }
    );
  }

  Widget _getBottomArea(){
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    Text('Rs. ${widget.order.totalPrice} /-',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                      ),
                    )
                  ],
                ),
              ),
              FloatingActionButton(
                backgroundColor: (widget.order.totalPrice == null || widget.order.totalPrice == 0.0) ? Colors.grey : Colors.amber,
                child: Text("Order"),
                onPressed: (widget.order.totalPrice == null || widget.order.totalPrice == 0.0) ?
                null : () async {
                  await _displayDialogForCustomerNameInput(context);
                }
              ),
            ],
          ),
        )
    );
  }

  Widget _getMenuCard(int index){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02 , vertical: screenHeight * 0.02),
        child: _getCardForMenuItem(index: index, screenHeight: screenHeight, screenWidth: screenWidth)
    );
  }

  Widget _getCardForMenuItem({int index, double screenHeight, double screenWidth}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _getItemDetailsWidget(index: index, screenHeight: screenHeight, screenWidth: screenWidth),
        _getCountButtonWidget(index: index, screenWidth: screenWidth, screenHeight: screenHeight),
      ],
    );
  }

  Widget _getItemDetailsWidget({int index, double screenHeight, double screenWidth}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
          width: screenWidth * 0.6,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
                color: Colors.teal,
                width: 1
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(
                      'assets/images/${widget.menuList[index].imgPath}.jpg'
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: _itemNameList(screenWidth: screenWidth, index: index),
                    ),
                    Text(
                        'Rs. ${widget.menuList[index].price} /-',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                        )
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  List<Widget> _itemNameList({int index, double screenWidth}){
    List<Widget> widgetList = [];
    String itemName = widget.menuList[index].itemName;
    List<String> words = (itemName != null) ? itemName.split(" ") : [];
    words.forEach((word) =>
        widgetList.add(
            Text(
                '$word',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                )
            )
        )
    );
    return widgetList;
  }

  Widget _getCountButtonWidget({int index, double screenWidth, double screenHeight}) {

    return Container(
      width: screenWidth * 0.3,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(
            color: Colors.amber,
            width: 1
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            color: Colors.teal,
            icon: Icon(Icons.minimize),
            onPressed: (widget.items[index] != null && widget.items[index].count == 0) ? null : (){
              double prevPrice = widget.menuList[index].price * widget.items[index].count;

              setState(() {
                widget.items[index].count --;
              });
              _editItem(index: index, prevPrice: prevPrice);
            },
          ),
          Text(
              '${widget.items[index].count}',
              style: TextStyle(
                fontSize: 20,
              )
          ),
          IconButton(
            color: Colors.teal,
            icon: Icon(Icons.add),
            onPressed: (widget.items[index] != null && widget.items[index].count > 4) ? null : (){
              double prevPrice = widget.menuList[index].price * widget.items[index].count;
              setState(() {
                widget.items[index].count ++;
              });
              _editItem(index: index, prevPrice: prevPrice);
            },
          )

        ],
      ),
    );
  }

  Future<Widget> _displayDialogForCustomerNameInput(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context){
            return AlertDialog(
              elevation: 2.0,
              contentPadding: EdgeInsets.all(8.0),
              backgroundColor: Colors.white70,
              title: Text('Customer Name'),
              content: TextField(
                onSubmitted: (String inputName){
                  if (inputName != null && inputName.isNotEmpty) {
                    if(this.mounted){
                      setState(() {
                        widget.order.customerName = inputName;
                      });
                    }
                  }
                },
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: (widget.order.customerName == null || widget.order.customerName.isEmpty) ? null : ()=> _makeOrder()
                )
              ],
            );
        },
    );
  }

  _initializeOrder(){
    setState(() {
      widget.order = Order();
      widget.order.totalPrice = 0.0;
    });
  }
  _setMenuList() async{
    await _orderAPIService.getMenu().then((list) {
      if(list != null && list.isNotEmpty){
        setState(() {
          widget.menuList = list;
          _initializeItems();
        });
       }else{
        //error
      }
      }
    );
  }

  _initializeItems(){

    for(Menu menu in widget.menuList){
      Item item = Item();
      item.count = 0;
      item.itemId = menu.itemId;
      item.itemName = menu.itemName;
      item.price = 0.0;
      widget.items.add(item);
    }
  }

   _editItem({int index, double prevPrice}) {
    setState(() {
      if(widget.items[index] != null){
        widget.items[index].price = widget.menuList[index].price * widget.items[index].count;
        if (widget.items[index].count > 0) {
          if (widget.order.items == null) {
            widget.order.items = HashSet<Item>();
            widget.order.items.add(widget.items[index]);
            widget.order.totalPrice += widget.items[index].price;
          } else {
            _addRemoveItem(inputItem: widget.items[index], toAdd: true, prevPrice: prevPrice);
          }
        }else{
          _addRemoveItem(inputItem: widget.items[index], toAdd: false, prevPrice: prevPrice);
        }
      }
    });
  }
  _addRemoveItem({Item inputItem, bool toAdd, double prevPrice}){

    bool isExists = widget.order.items.any((item) => item.itemId == inputItem.itemId);
    setState(() {
      if(isExists) {
        widget.order.items.removeWhere((item) => item.itemId == inputItem.itemId);
        widget.order.totalPrice -= prevPrice;
        if(!toAdd){
          setState(() {

          });
        }
      }
      if(toAdd){
        widget.order.items.add(inputItem);
        widget.order.totalPrice += inputItem.price;
      }
    });
  }

   _makeOrder() async{
    await _orderAPIService.placeOrder(widget.order).then((savedOrder) {
      if(savedOrder.orderId != null){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => OrderDetails(order: savedOrder, enableBack: false,),
        )
        );
      }else{
        //error
      }
      }
    );
  }

}