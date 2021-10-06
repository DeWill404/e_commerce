import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  String imagePath = "";

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    loginStatus().then((useStr) {
      List<String> user = useStr.split(":");
      getImagePath(new User(user_email: user[0], user_password: user[1]))
          .then((path) {
        setState(() {
          widget.imagePath = path;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: widget.imagePath == ""
                ? AssetImage("assets/images/Profile Image.png")
                : Image.file(File(widget.imagePath)).image,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Color(0x21FFFFFF),
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          backgroundColor: Color(0xFF33334F),
                          title: Text("Select Image : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: SimpleDialogOption(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text("Open Camera",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () async {
                                    XFile? image = await imagePicker.pickImage(
                                        source: ImageSource.camera);
                                    if (image != null) {
                                      loginStatus().then((useStr) {
                                        List<String> user = useStr.split(":");
                                        updateImage(
                                            new User(
                                                user_email: user[0],
                                                user_password: user[1]),
                                            image.path);
                                      });
                                      setState(
                                          () => widget.imagePath = image.path);
                                    }
                                    Navigator.pop(context, true);
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: SimpleDialogOption(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text("Open Gallery",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () async {
                                    XFile? image = await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      loginStatus().then((useStr) {
                                        List<String> user = useStr.split(":");
                                        updateImage(
                                            new User(
                                                user_email: user[0],
                                                user_password: user[1]),
                                            image.path);
                                      });
                                      setState(
                                          () => widget.imagePath = image.path);
                                    }
                                    Navigator.pop(context, true);
                                  },
                                ))
                          ],
                        );
                      }),
                  child: SvgPicture.asset(
                    "assets/icons/Camera Icon.svg",
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
