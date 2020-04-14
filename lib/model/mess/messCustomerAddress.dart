
class MessCustomerAddress{
  int houseNo;
  String locality;
  String city;

  MessCustomerAddress({this.houseNo, this.locality, this.city});

  MessCustomerAddress.fromJson(Map<String, dynamic> addressJson):
      houseNo = addressJson['houseNo'],
      locality = addressJson['locality'],
      city = addressJson['city'];

  Map<String, dynamic> toJson(){
    return {
      'houseNo' : houseNo,
      'locality'  : locality,
      'city'  : city,
    };
  }
}

