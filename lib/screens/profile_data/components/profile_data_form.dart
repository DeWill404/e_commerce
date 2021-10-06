import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/profile/components/profile_menu.dart';


class ProfileDataForm extends StatefulWidget {
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String address = "";

  @override
  _ProfileDataFormState createState() => _ProfileDataFormState();
}

class _ProfileDataFormState extends State<ProfileDataForm> {
  @override
  void initState() {
    super.initState();
    loginStatus().then((value) {
      List<String> lst = value.split(":");
      getDetails(new User(user_email: lst[0], user_password: lst[1])).then((v) {
        List<String> details = v.split(":");
        setState(() {
          widget.firstName = details[0];
          widget.lastName = details[1];
          widget.phoneNumber = details[2];
          widget.address = details[3];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        ProfileMenu(
          text: "${widget.firstName} ${widget.lastName}",
          icon: "assets/icons/User.svg",
          press: () {},
        ),
        ProfileMenu(
          text: widget.phoneNumber,
          icon: "assets/icons/Phone.svg",
          press: () {},
        ),
        ProfileMenu(
          text: widget.address,
          icon: "assets/icons/Location point.svg",
          press: () {},
        ),
      ]),
    );
  }
}
