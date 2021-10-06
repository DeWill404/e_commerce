import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shop_app/models/User.dart';

const List<Color> colorList = [
  Color(0xFFF6625E),
  Color(0xFF836DB8),
  Color(0xFFDECB9C),
  Colors.white,
];

class Product {
  int selected;
  String title, description;
  List<String> images;
  List<Color> colors;
  double rating, price;
  bool isFavourite, rated;

  Product({
    this.selected = 0,
    required this.images,
    this.colors = colorList,
    this.rating = 0.0,
    this.isFavourite = false,
    required this.title,
    required this.price,
    required this.description,
    this.rated = false,
  });
}

// get data from firebase
final database = FirebaseDatabase.instance.reference();

void getDataFromFirebase(refresh) {
  database.child("/products/").once().then((snapshot) {
    demoProducts = [];
    List<Object?> list = snapshot.value;
    for (int i = 0; i < list.length; i++) {
      Map<dynamic, dynamic> map = (list[i] as Object) as Map<dynamic, dynamic>;
      List<String> temp = [];
      for (int j = 0; j < map["images"].length; j++)
        temp.add(map["images"][j] as String);
      demoProducts = [
        ...demoProducts,
        Product(
            images: [...temp],
            title: map["title"],
            price: map["price"],
            description: map["description"],
            isFavourite: map["isFavorite"],
            rating: map["rating"])
      ];
    }
    getCart().then((value) {
      print(value);
      if (value != "") {
        List<String> cart = value.split(":");
        for (String pair in cart) {
          List<String> lst = pair.split(",");
          demoProducts[int.parse(lst.first)].selected = int.parse(lst.last);
        }
      }
      refresh();
    });
  });
}

// Our demo Products
List<Product> demoProducts = [];
