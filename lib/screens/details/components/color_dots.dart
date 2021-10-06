import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  ColorDots(
      {Key? key,
      required this.product,
      required this.index,
      required this.prod_count,
      required this.increaseProd,
      required this.decreaseProd})
      : super(key: key);

  final Product product;
  final int index;
  int selectedColor = 0;
  int prod_count;
  final Function increaseProd;
  final Function decreaseProd;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => ColorDot(
                color: widget.product.colors[index],
                isSelected: index == widget.selectedColor,
                press: () {
                  if (index != widget.selectedColor) {
                    setState(() {
                      widget.selectedColor = index;
                    });
                  }
                }),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              if (widget.prod_count > 0) {
                setState(() {
                  widget.prod_count = widget.decreaseProd();
                });
              }
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(widget.prod_count.toString(),
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            press: () {
              if (widget.prod_count < 20) {
                setState(() {
                  widget.prod_count = widget.increaseProd();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
    required this.press,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
