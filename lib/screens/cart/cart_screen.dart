import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  List<Pair> carts = <Pair>[];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void refresh() {
    setState(() {});
    updateCart();
  }

  int getCnt() {
    int sum = 0;
    for (int i = 0; i < widget.carts.length; i++)
      sum += widget.carts[i].right as int;
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    widget.carts = generateCart();
    final Function agrs =
        ModalRoute.of(context)!.settings.arguments as Function;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(refresh: refresh, refreshHome: agrs, carts: widget.carts),
      bottomNavigationBar: CheckoutCard(
          refresh: refresh, refreshHome: agrs, carts: widget.carts),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            widget.carts.length > 0 ? " ${this.getCnt()} items" : "",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
