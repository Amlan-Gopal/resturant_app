import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:resturantapp/model/mess/messCustomer.dart';

class MessAPIService{

  final String baseURI = "http://192.168.0.2:8000/resturant/mess-service";

  Future<List<MessCustomer>> getAllMessCustomers() async {
    List<MessCustomer> allMessCustomers = List<MessCustomer>();

    final response = await http.get('$baseURI/mess/all');
    if(response.statusCode == 200){
        List list = json.decode(response.body);

        for(var mess in list){
          MessCustomer messCustomer = MessCustomer.fromJson(mess);
          allMessCustomers.add(messCustomer);
        }
    }else if(response.statusCode == 404){
      print("No mess member available");
    }else{
      print('${response.statusCode}');
      print("server errror");
    }

    return allMessCustomers;
  }

  Future<MessCustomer> addNewCustomer(MessCustomer inputCustomer) async{
    MessCustomer savedMessCustomer = MessCustomer();
    
    final response = await http.post('$baseURI/mess/add',
        headers: <String, String> {'Content-Type': 'application/json; charset=UTF-8',},
        body: jsonEncode(inputCustomer.toJson()),
    );

    if(response.statusCode == 201){
      print('created');
      savedMessCustomer = MessCustomer.fromJson(json.decode(response.body));
    }else{
      print(response.statusCode);
      print('server error');
    }
    
    return savedMessCustomer;
  }

  Future<MessCustomer> clearDue(int messId, int amount) async{
    MessCustomer savedMessCustomer = MessCustomer();
    
    final response = await http.put('$baseURI/mess/pay/$messId/$amount');

    if(response.statusCode == 202){
      savedMessCustomer = MessCustomer.fromJson(json.decode(response.body));
    }else{
      print(response.statusCode);
      print('server error');
    }
    
    return savedMessCustomer;
  }

}