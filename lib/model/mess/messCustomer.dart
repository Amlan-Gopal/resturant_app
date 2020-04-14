import 'package:resturantapp/model/mess/messCustomerDetails.dart';

class MessCustomer{
  int messId;
  MessCustomerDetails customerDetails;
  DateTime startingDate;
  DateTime paidDate;
  DateTime currentDate;
  bool isPaid;
  int pendingMonths;

  MessCustomer({this.messId, this.customerDetails, this.startingDate, this.paidDate, this.currentDate, this.isPaid, this.pendingMonths});

  MessCustomer.fromJson(Map<String, dynamic> customerJson):
      messId = customerJson['messId'],
      customerDetails = _parseCustomerDetails(customerJson['customer']),
      startingDate = DateTime.parse(customerJson['startingDate']),
      paidDate = DateTime.parse(customerJson['paidDate']),
      currentDate = DateTime.parse(customerJson['currentDate']),
      isPaid = customerJson['isPaid'],
      pendingMonths = customerJson['pendingMonths'];

  Map<String, dynamic> toJson(){
      return {
        "customer"  : _formatCustomerDetails(this.customerDetails),
      };
  }

  static MessCustomerDetails _parseCustomerDetails(customerDetailsJson){
    return MessCustomerDetails.fromJson(customerDetailsJson);
  }

  static dynamic _formatCustomerDetails(MessCustomerDetails customerDetails){
    return customerDetails.toJson();
}
}