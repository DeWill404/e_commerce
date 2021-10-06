import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/details/components/custom_snackbar.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  OtpForm({Key? key, required this.agrs}) : super(key: key);

  OtpArguments agrs;
  List<String> digit = ["", "", "", ""];

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    widget.digit[0] = value;
                    nextField(value, pin2FocusNode);
                  },
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    widget.digit[1] = value;
                    nextField(value, pin3FocusNode);
                  },
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    widget.digit[2] = value;
                    nextField(value, pin4FocusNode);
                  },
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                      widget.digit[3] = value;
                      int num = int.parse(widget.digit[0]) * 1000 +
                          int.parse(widget.digit[1]) * 100 +
                          int.parse(widget.digit[2]) * 10 +
                          int.parse(widget.digit[3]);
                      if (widget.agrs.otp.resultChecker(num)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                txt: "OTP is verified.", context: context));
                        addUser(widget.agrs.user, widget.agrs.detail);
                        login(widget.agrs.user);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                txt: "Invalid OTP.", context: context));
                      }
                    }
                  },
                  maxLength: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              int num = int.parse(widget.digit[0]) * 1000 +
                  int.parse(widget.digit[1]) * 100 +
                  int.parse(widget.digit[2]) * 10 +
                  int.parse(widget.digit[3]);
              if (widget.agrs.otp.resultChecker(num)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackbar(txt: "OTP is verified.", context: context));
                addUser(widget.agrs.user, widget.agrs.detail);
                login(widget.agrs.user);
                Navigator.pushNamed(context, HomeScreen.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackbar(txt: "Invalid OTP.", context: context));
              }
            },
          )
        ],
      ),
    );
  }
}
