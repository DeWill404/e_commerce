import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.product.rating, index: agrs.index),
      ),
      body: Body(product: agrs.product, index: agrs.index, refresh: agrs.refresh),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final int index;
  final Function refresh;

  ProductDetailsArguments({required this.product, this.index = 0, required this.refresh});
}
