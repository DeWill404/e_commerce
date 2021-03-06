import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/size_config.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  final User user;
  Body({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Complete Profile",
                    style: TextStyle(
                      color: Color(0xFFAE00FB),
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  "Complete your details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(user: user),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text("By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Colors.white70),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
