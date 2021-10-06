import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/complete_profile";

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Body(user: user),
    );
  }
}
