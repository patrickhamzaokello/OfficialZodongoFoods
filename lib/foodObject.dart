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

  Map<String, dynamic> toMap() {
    return {
      // 'foodid': foodid,
      'name': name,
      'price': price,
      'description': decription,
      // 'imagepath': imagepath,
      'quantity': quantity
    };
  }
}
