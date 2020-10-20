class Food {
  final String foodid;
  final String name;
  final String price;
  final String description;
  final String imagepath;
  final int quantity;

  String pricechange = '0';
  int qtnchange = 1;

  Food(
      {this.foodid,
      this.name,
      this.price,
      this.description,
      this.imagepath,
      this.quantity,
      this.pricechange,
      this.qtnchange});

  //convert to sent to firestore

  Map<String, dynamic> toMap() {
    return {
      'foodid': foodid,
      'name': name,
      'price': price,
      'description': description,
      'imagepath': imagepath,
      'quantity': quantity,
    };
  }

  //get from cloud store

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['name'],
        price: json['price'],
        description: json['description'],
        imagepath: json['imagepath'],
        quantity: json['quantity'],
        foodid: json['foodid']);
  }
}
