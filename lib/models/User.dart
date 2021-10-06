import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  String? s = directory?.path;
  print(directory?.path);
  return s!;
}

Future<File> get _userFile async {
  final path = await _localPath;
  return File('$path/user.txt');
}

Future<File> get _detailsFile async {
  final path = await _localPath;
  return File('$path/details.txt');
}

Future<File> get _cartFile async {
  final path = await _localPath;
  return File('$path/cart.txt');
}

Future<File> get _loginFile async {
  final path = await _localPath;
  return File('$path/login.txt');
}

void addUser(User user, Detail detail) async {
  final file1 = await _userFile;
  file1.writeAsString(user.toString() + "\n", mode: FileMode.append);
  final file2 = await _detailsFile;
  file2.writeAsString(detail.toString() + ":\n", mode: FileMode.append);
  final file3 = await _cartFile;
  file3.writeAsString("\n", mode: FileMode.append);
}

Future<String> getDetails(User user) async {
  try {
    final file1 = await _userFile;
    String contents1 = await file1.readAsString();
    List<String> userList = contents1.split("\n");
    int index = userList.indexOf(user.toString());
    final file2 = await _detailsFile;
    String contents2 = await file2.readAsString();
    List<String> detailList = contents2.split("\n");
    return detailList[index];
  } catch (e) {
    return "";
  }
}

Future<bool> updateImage(User user, String imagePath) async {
  try {
    final file1 = await _userFile;
    String contents1 = await file1.readAsString();
    List<String> userList = contents1.split("\n");
    int index = userList.indexOf(user.toString());
    final file2 = await _detailsFile;
    String contents2 = await file2.readAsString();
    List<String> detailList = contents2.split("\n");
    String curr = detailList[index];
    List<String> lst = curr.split(":");
    lst[4] = imagePath;
    detailList[index] = lst.join(":");
    contents2 = detailList.join(("\n")) + "\n";
    file2.writeAsString(contents2);
    return true;
  } catch (e) {
    return false;
  }
}

Future<String> getImagePath(User user) async {
  try {
    final file1 = await _userFile;
    String contents1 = await file1.readAsString();
    List<String> userList = contents1.split("\n");
    int index = userList.indexOf(user.toString());
    final file2 = await _detailsFile;
    String contents2 = await file2.readAsString();
    List<String> detailList = contents2.split("\n");
    String details = detailList[index];
    return details.split(":")[4];
  } catch (e) {
    return "";
  }
}

Future<bool> validUser(User user) async {
  try {
    final file = await _userFile;
    String contents = await file.readAsString();
    Set<String> userSet = contents.split("\n").toSet();
    return userSet.contains(user.toString());
  } catch (e) {
    return false;
  }
}

void login(User user) async {
  final file = await _loginFile;
  file.writeAsString(user.toString());
}

void logout() async {
  final file = await _loginFile;
  file.writeAsString("");
}

Future<String> loginStatus() async {
  try {
    final file = await _loginFile;
    return await file.readAsString();
  } catch (e) {
    return "";
  }
}

class User {
  String user_email = "";
  String user_password = "";

  User({required this.user_email, required this.user_password});

  void setFromString(String s) {
    List<String> l = s.split(":");
    this.user_email = l.first;
    this.user_password = l.last;
  }

  @override
  String toString() {
    return "${user_email.trim().toLowerCase()}:${user_password.trim()}";
  }
}

class Detail {
  String firstName = "";
  String lastName = "";
  String number = "";
  String address = "";

  Detail(
      {required this.firstName,
      required this.lastName,
      required this.number,
      required this.address});

  @override
  String toString() {
    return "${firstName.trim().toLowerCase()}:${lastName.trim().toLowerCase()}:${number.trim().toLowerCase()}:${address.trim().toLowerCase()}";
  }
}

Future<String> getCart() async {
  try {
    final file = await _cartFile;
    String content = await file.readAsString();
    print(content);
    List<String> cart = content.split("\n");

    String user = await loginStatus();
    final file1 = await _userFile;
    String content1 = await file1.readAsString();
    return cart[content1.split("\n").indexOf(user)];
  } catch (e) {
    return "";
  }
}

List<Pair> generateCart() {
  List<Pair> carts = [];
  for (int i = 0; i < demoProducts.length; i++)
    if (demoProducts[i].selected > 0)
      carts.add(Pair(i, demoProducts[i].selected));
  return carts;
}

Future<bool> updateCart() async {
  try {
    String user = await loginStatus();
    final file1 = await _userFile;
    String contents1 = await file1.readAsString();
    List<String> userList = contents1.split("\n");
    int index = userList.indexOf(user);

    final file2 = await _cartFile;
    String contents2 = await file2.readAsString();
    List<String> cartList = contents2.split("\n");

    List<Pair> cart = generateCart();
    List<String> s = [];
    for (Pair pair in cart) s.add("${pair.left},${pair.right}");
    cartList[index] = s.join(":");

    file2.writeAsString(cartList.join("\n") + "\n");
    return true;
  } catch (e) {
    return false;
  }
}

Future<File> get _locationFile async {
  final path = await _localPath;
  return File('$path/location.txt');
}

Future<LatLng> getLocation() async {
  try {
    final file = await _locationFile;
    String s = await file.readAsString();
    return LatLng(
        double.parse(s.split(":").first), double.parse(s.split(":").last));
  } catch (e) {
    LocationData ld = await Location().getLocation();
    return LatLng(ld.latitude!, ld.longitude!);
  }
}

void setLocation(LatLng l) async {
  final file = await _locationFile;
  print("${l.latitude}:${l.longitude}");
  file.writeAsString("${l.latitude}:${l.longitude}");
}
