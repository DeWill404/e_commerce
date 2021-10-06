import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.refresh
  }) : super(key: key);
  final Function refresh;

  int getCartProd() {
    int sum = 0;
    for (int i = 0; i < demoProducts.length; i++)
      sum += demoProducts[i].selected;
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: getCartProd(),
            press: () => Navigator.pushNamed(
              context, 
              CartScreen.routeName, 
              arguments:this.refresh
            ),
          ),
        ],
      ),
    );
  }
}
