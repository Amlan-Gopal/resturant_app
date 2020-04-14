import 'package:resturantapp/model/mess/messCustomerAddress.dart';

class MessCustomerDetails{
  int customerId;
  String customerName;
  String phoneNumber;
  MessCustomerAddress customerAddress;

  MessCustomerDetails({this.customerId, this.customerName, this.phoneNumber, this.customerAddress});

  MessCustomerDetails.fromJson(Map<String, dynamic> customerDetailsJson):
      customerId = customerDetailsJson['customerId'],
      customerName = customerDetailsJson['customerName'],
      phoneNumber = customerDetailsJson['phoneNumber'],
      customerAddress = _parseAddress(customerDetailsJson['address']);

  Map<String, dynamic> toJson(){
      return {
        "customerName"  : this.customerName,
        "phoneNumber" : this.phoneNumber,
        "address" : _formatAddress(this.customerAddress),
      };
  }

  static MessCustomerAddress _parseAddress(addressJson){
    return MessCustomerAddress.fromJson(addressJson);
  }

  static dynamic _formatAddress(MessCustomerAddress customerAddress){
    return customerAddress.toJson();
  }
}