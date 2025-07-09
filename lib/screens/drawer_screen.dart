import 'package:flutter/material.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:rydex/global/global.dart';
import 'package:rydex/screens/profile_scren.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue, shape: BoxShape.circle),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  20.h,
                  ReuseableText(
                    title: UserModelCurrentInfo?.name! ?? "User",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  20.h,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                    child: ReuseableText(
                        title: "Edit Profile",
                        style:
                            TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),
                  ),

                          20.h,
                  ReuseableText(
                      title: "Your Trips",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),
                          20.h,
                  ReuseableText(
                      title: "Payments",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),
                          20.h,
                  ReuseableText(
                      title: "Notification",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),
                          20.h,
                  ReuseableText(
                      title: "Discounts",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),

                          20.h,
                  ReuseableText(
                      title: "Help",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),

                          20.h,
                  ReuseableText(
                      title: "Free Trips",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),

                ],
              ),
              Spacer(),

              GestureDetector(
                onTap: () {},
                child: ReuseableText(
                      title: "Log Out",
                      style:
                          TextStyle(fontSize: 15, color: Colors.lightBlue,fontWeight: FontWeight.bold),),

              )
            ],
          ),
        ),
      ),
    );
  }
}
