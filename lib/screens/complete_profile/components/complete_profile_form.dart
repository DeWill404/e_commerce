import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/components/otp_sms.dart';
import 'package:shop_app/screens/map/map_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  final User user;
  CompleteProfileForm({Key? key, required this.user}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  Location location = new Location();
  LatLng curr = LatLng(0, 0);


  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    getLocation().then((value) => curr = value);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                CustomOtp otp = CustomOtp();
                otp.sendOtp(phoneNumber!);
                Navigator.pushNamed(context, OtpScreen.routeName,
                    arguments: OtpArguments(
                        user: widget.user,
                        detail: new Detail(
                            firstName: firstName!,
                            lastName: lastName!,
                            number: phoneNumber!,
                            address: address!),
                        otp: otp));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue!.trim(),
      onChanged: (value) {
        address = value;
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: "Address",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Enter your phone address",
        hintStyle: TextStyle(color: Colors.white38),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MyMap.routeName, arguments: curr);
            },
            child:
                CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg")),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        phoneNumber = value;
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Enter your phone number",
        hintStyle: TextStyle(color: Colors.white38),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!.trim().toLowerCase(),
      onChanged: (value) {
        lastName = value;
      },
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: "Last Name",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Enter your last name",
        hintStyle: TextStyle(color: Colors.white38),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue!.trim().toLowerCase(),
      onChanged: (value) {
        firstName = value;
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: "First Name",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Enter your first name",
        hintStyle: TextStyle(color: Colors.white38),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
