import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({required this.txt, required this.context})
      : super(
          content: Text(
            txt,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.1),
          ),
          backgroundColor: kPrimaryColor,
          dismissDirection: DismissDirection.horizontal,
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.9,
        );
  final String txt;
  final BuildContext context;
}
