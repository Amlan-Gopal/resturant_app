import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:resturantapp/model/order/menu.dart';
import 'package:resturantapp/model/order/order.dart';

class OrderAPIService{

  final String baseURI = "http://192.168.0.2:8000/resturant/order-service";

  Future<List<Menu>> getMenu() async {
    List<Menu> menuList = List<Menu>();

  final response = await http.get('$baseURI/menu/items');
    if(response.statusCode == 200){
        List list = json.decode(response.body);

        for(var itemJson in list){
          Menu menu = Menu.fromJson(itemJson);
          menuList.add(menu);
        }
    }else if(response.statusCode == 404){
        print("No menu available");
    }else{
      print('${response.statusCode}');
      print("server error");
    }

    return menuList;
  }

  Future<Order> placeOrder(Order inputOrder) async {
    Order savedOrder = new Order();

    final response = await http.post('$baseURI/order/add', 
        headers: <String, String> {'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode(inputOrder.toJson())
    );

    if(response.statusCode == 201){
      print('created');
      savedOrder = Order.fromJson(json.decode(response.body));
    }else{
      print(response.statusCode);
      print('server error');
    }

    return savedOrder;
  }

  Future<List<Order>> getAllOrders() async{
    List<Order> orderList = List<Order>();
    final response = await http.get('$baseURI/order/all');
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      for(var orderJson in list){
        Order order = Order.fromJson(orderJson);
        orderList.add(order);
      }
    }else if(response.statusCode == 404){
      print("No order available");
    }else{
      print('${response.statusCode}');
      print("server error");
    }
    return orderList;
  }
}