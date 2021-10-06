import 'package:flutter/material.dart';
import 'package:shop_app/screens/profile_data/components/profile_data_form.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("My Account",
                    style: TextStyle(
                      color: Color(0xFFAE00FB),
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                ProfileDataForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
