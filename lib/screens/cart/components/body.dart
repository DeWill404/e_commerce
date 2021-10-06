import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body(
      {Key? key,
      required this.refresh,
      required this.refreshHome,
      required this.carts})
      : super(key: key);

  final Function refresh;
  final Function refreshHome;
  List<Pair> carts;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: Colors.white54,
        ),
        itemCount: widget.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                demoProducts[widget.carts[index].left].selected = 0;
                widget.carts.removeAt(index);
                widget.refresh();
                widget.refreshHome();
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0x20FFFFFF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg", color: Colors.white70,),
                ],
              ),
            ),
            child: CartCard(cart: widget.carts[index], refreshHome:widget.refreshHome, refresh:widget.refresh),
          ),
        ),
      ),
    );
  }
}
