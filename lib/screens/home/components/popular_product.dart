import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
    required this.refresh
  }) : super(key: key);
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Products", press: () {}),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, getProportionateScreenWidth(20),
              getProportionateScreenWidth(20), 0),
          child: getProductList(),
        ),
      ],
    );
  }

  Widget getProductList() {
    List<Widget> lst = [];

    for (int i = 0; i < demoProducts.length; i += 2) {
      List<Pair> temp = [];
      temp.add(Pair(demoProducts[i], i));
      if (i + 1 < demoProducts.length)
        temp.add(Pair(demoProducts[i + 1], i + 1));

      lst.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ...temp.map((pair) => ProductCard(
            product: pair.left, index: pair.right, refresh: this.refresh))
      ]));
    }

    return Column(children: lst);
  }
}
