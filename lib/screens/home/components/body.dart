import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
    getDataFromFirebase(refresh);
  }


  void refresh() {
    return setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(refresh:refresh),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            PopularProducts(refresh:refresh),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
