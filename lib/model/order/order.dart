import 'package:resturantapp/model/order/item.dart';

class Order{
  int orderId;
  String customerName;
  double totalPrice;
  DateTime orderDate;
  Set<Item> items;

  Order({this.orderId, this.customerName, this.totalPrice, this.orderDate, this.items});

  Order.fromJson(Map<String, dynamic> orderJson):
      orderId = orderJson['orderId'],
      customerName = orderJson['customerName'],
      totalPrice = orderJson['totalPrice'],
      orderDate = DateTime.parse(orderJson['orderDate']),
      items = _parseItems(orderJson['items']);

  Map<String, dynamic> toJson(){
    return {
        "customerName"  : this.customerName,
        "totalPrice"  : this.totalPrice,
        "items" : _formatItems(this.items),
    };
  }


  static Set<Item> _parseItems(itemsJson){
        var list = itemsJson as List;
        Set<Item> items = list.map((item) => Item.fromJson(item)).toSet();
        return items;
  }

   dynamic _formatItems(Set<Item> items){
    return items.map((item) => item.toJson()).toList();
  }

}