
class Menu{
  int itemId;
  String itemName;
  double price;
  String imgPath;

  Menu({this.itemId, this.itemName, this.price, this.imgPath});

  Menu.fromJson(Map<String, dynamic> menuJson):
      itemId = menuJson['itemId'],
      itemName = menuJson['itemName'],
      price = menuJson['price'],
      imgPath = menuJson['imgPath'];

}