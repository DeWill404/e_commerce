import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileDataScreen extends StatefulWidget {
  static String routeName = "/profile_data";

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Account")),
      body: Body(),
    );
  }
}
