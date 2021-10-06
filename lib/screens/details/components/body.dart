import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final int index;
  final Function refresh;
  int prod_count = -1;

  Body(
      {Key? key,
      required this.product,
      required this.index,
      required this.refresh})
      : super(key: key);

  int increaseProd() {
    this.prod_count += 1;
    return this.prod_count;
  }

  int decreaseProd() {
    this.prod_count -= 1;
    return this.prod_count;
  }

  @override
  Widget build(BuildContext context) {
    this.prod_count =
        this.prod_count == -1 ? demoProducts[index].selected : this.prod_count;
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Color(0x21FFFFFF),
          child: Column(
            children: [
              ProductDescription(
                  product: product, index: index, refresh: refresh),
              TopRoundedContainer(
                color: Color(0x18FFFFFF),
                child: Column(
                  children: [
                    ColorDots(
                        product: product,
                        index: index,
                        prod_count: this.prod_count,
                        increaseProd: increaseProd,
                        decreaseProd: decreaseProd),
                    TopRoundedContainer(
                      color: Color(0xFF222123),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            product.selected = this.prod_count;
                            updateCart();
                            this.refresh();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
