
class Item{
  int itemId;
  String itemName;
  int count;
  double price;

  Item({this.itemId, this.itemName, this.count, this.price});

  Item.fromJson(Map<String, dynamic> itemJson):
      itemId = itemJson['itemID'],
      itemName = itemJson['itemName'],
      count = itemJson['count'],
      price = itemJson['price'];

  Map<String, dynamic> toJson(){
    return {
      'itemID' :  this.itemId,
      'itemName' : this.itemName,
      'count' : this.count,
      'price' : this.price,
    };
  }
}