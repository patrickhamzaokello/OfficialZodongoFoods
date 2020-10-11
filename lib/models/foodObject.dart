class Food {
  final String foodid;
  final String name;
  String price;
  final String decription;
  final String imagepath;
  int quantity;

  Food(
      {this.foodid,
      this.name,
      this.price,
      this.decription,
      this.imagepath,
      this.quantity});

  //convert to sent to firestore

  Map<String, dynamic> toMap() {
    return {
      'foodid': foodid,
      'name': name,
      'price': price,
      'description': decription,
      'imagepath': imagepath,
      'quantity': quantity,
    };
  }

  //get from cloud store

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['name'],
        price: json['price'],
        decription: json['decription'],
        imagepath: json['imagepath'],
        quantity: json['quantity'],
        foodid: json['foodid']);
  }
}
