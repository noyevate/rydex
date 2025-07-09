import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/global/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();

  DatabaseReference userRef = FirebaseDatabase.instance.ref().child('rydex-users');

  Future<void> showUserNameDialogAlert(
      BuildContext context, String name, bool darkTheme) {
    nameTextEditingController.text = name;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReuseableText(
              title: "update",
              style: TextStyle(
                  color: darkTheme ? Colors.amber.shade400 : Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    'name': nameTextEditingController.text.trim(),


                  }).then((value) {
                    nameTextEditingController.clear();
                    Fluttertoast.showToast(msg: "Updated Successfully. \n Reload app to see changes.");
                  }).catchError((errorMesg) {
                    Fluttertoast.showToast(msg: "An error occured. \n $errorMesg");
                  });
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Ok",
                  style: TextStyle(
                      color: darkTheme ? Colors.amber.shade400 : Colors.black),
                ),
              ),
            ],
          );
        });
  }



  Future<void> showUserPhoneDialogAlert(
      BuildContext context, String phone, bool darkTheme) {
    phoneTextEditingController.text = phone;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReuseableText(
              title: "update",
              style: TextStyle(
                  color: darkTheme ? Colors.amber.shade400 : Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: phoneTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    'phone': phoneTextEditingController.text.trim(),


                  }).then((value) {
                    phoneTextEditingController.clear();
                    Fluttertoast.showToast(msg: "Updated Successfully. \n Reload app to see changes.");
                  }).catchError((errorMesg) {
                    Fluttertoast.showToast(msg: "An error occured. \n $errorMesg");
                  });
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Ok",
                  style: TextStyle(
                      color: darkTheme ? Colors.amber.shade400 : Colors.black),
                ),
              ),
            ],
          );
        });
  }






  Future<void> showAddressNameDialogAlert(
      BuildContext context, String address, bool darkTheme) {
    addressTextEditingController.text = address;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReuseableText(
              title: "update",
              style: TextStyle(
                  color: darkTheme ? Colors.amber.shade400 : Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: addressTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    'address': addressTextEditingController.text.trim(),


                  }).then((value) {
                    addressTextEditingController.clear();
                    Fluttertoast.showToast(msg: "Updated Successfully. \n Reload app to see changes.");
                  }).catchError((errorMesg) {
                    Fluttertoast.showToast(msg: "An error occured. \n $errorMesg");
                  });
                  Navigator.pop(context);
                },
                child: ReuseableText(
                  title: "Ok",
                  style: TextStyle(
                      color: darkTheme ? Colors.amber.shade400 : Colors.black),
                ),
              ),
            ],
          );
        });
  }






  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
                color: darkTheme ? Colors.white : Colors.black),
          ),
          title: ReuseableText(
            title: "Profile",
            style: TextStyle(color: darkTheme ? Colors.white : Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue, shape: BoxShape.circle),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                30.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: UserModelCurrentInfo?.name! ?? "User",
                      style: TextStyle(
                        color: darkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (UserModelCurrentInfo?.name != null) {
                          showUserNameDialogAlert(
                              context, UserModelCurrentInfo!.name!, darkTheme);
                        } else {
                          showUserNameDialogAlert(context, "User", darkTheme);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: darkTheme ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: darkTheme ? Colors.white : Colors.grey,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: UserModelCurrentInfo?.phone ?? "+23470XXXX543",
                      style: TextStyle(
                        color: darkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (UserModelCurrentInfo?.phone != null) {
                          showUserPhoneDialogAlert(
                              context, UserModelCurrentInfo!.phone!, darkTheme);
                        } else {
                          showUserPhoneDialogAlert(context, "23470XXXX543", darkTheme);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: darkTheme ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: darkTheme ? Colors.white : Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: UserModelCurrentInfo?.address! ?? "No 10 adebayo str",
                      style: TextStyle(
                        color: darkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (UserModelCurrentInfo?.address != null) {
                          showAddressNameDialogAlert(
                              context, UserModelCurrentInfo!.address!, darkTheme);
                        } else {
                          showAddressNameDialogAlert(context, "No 10 adebayo str", darkTheme);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: darkTheme ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: darkTheme ? Colors.white : Colors.grey,
                ),
                ReuseableText(
                  title: UserModelCurrentInfo?.email! ?? "samuel@example.com",
                  style: TextStyle(
                    color: darkTheme ? Colors.white : Colors.black,
                  ),
                ),
                

              ],
            ),
          ),
        ),
      ),
    );
  }
}
