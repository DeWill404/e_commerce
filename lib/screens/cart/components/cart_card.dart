import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.refresh,
    required this.refreshHome,
  }) : super(key: key);

  final Pair cart;
  final Function refresh;
  final Function refreshHome;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(demoProducts[cart.left].images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                demoProducts[cart.left].title,
                style: TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "\$${demoProducts[cart.left].price}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                  Text(
                    " x${demoProducts[cart.left].selected}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  RoundedIconBtn(
                      icon: Icons.remove,
                      press: () {
                        demoProducts[this.cart.left].selected -= 1;
                        this.refresh();
                        this.refreshHome();
                        updateCart();
                      }),
                  SizedBox(width: 10),
                  RoundedIconBtn(
                      icon: Icons.add,
                      press: () {
                        if (demoProducts[this.cart.left].selected < 20) {
                          demoProducts[this.cart.left].selected += 1;
                          this.refresh();
                          this.refreshHome();
                          updateCart();
                        }
                      }),
                  SizedBox(width: 15),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
