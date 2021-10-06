import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatefulWidget {
  final double rating;
  final int index;

  CustomAppBar({required this.rating, required this.index});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  backgroundColor: Color(0X21FFFFFF),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: demoProducts[this.widget.index].rated
                    ? Colors.white
                    : Color(0x21FFFFFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    demoProducts[this.widget.index].rated =
                        !demoProducts[this.widget.index].rated;
                    demoProducts[this.widget.index].rating =
                        demoProducts[this.widget.index].rating +
                            (demoProducts[this.widget.index].rated
                                ? 0.1
                                : -0.1);
                  });
                },
                child: Row(
                  children: [
                    Text(
                      "${demoProducts[this.widget.index].rating.toStringAsFixed(1)}",
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/icons/Star Icon.svg",
                        color: kPrimaryColor),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
