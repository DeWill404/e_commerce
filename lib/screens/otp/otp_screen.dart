import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/components/otp_sms.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final OtpArguments agrs =
        ModalRoute.of(context)!.settings.arguments as OtpArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(agrs: agrs),
    );
  }
}

class OtpArguments {
  final User user;
  final Detail detail;
  final CustomOtp otp;
  OtpArguments({required this.user, required this.detail, required this.otp});
}
