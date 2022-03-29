import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/free_service.dart';
import 'package:mosafer1/home/drawer/profile_page.dart';
import 'package:mosafer1/home/drawer/terms_and_policies.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'customer_service.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CacheHelper.getData(key: "token") == null ? Container(
            height: 200,
            decoration: BoxDecoration(
              color: MyTheme.mainAppBlueColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: HexColor("#FFFFFF"),
                  backgroundImage: AssetImage("assets/man.png"),
                ),
              ],
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: MyTheme.mainAppBlueColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("عميل موثوق",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: double.infinity,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            height: 80,
                            width: 80,
                            placeholderCacheHeight: 80,
                            placeholderCacheWidth: 80,
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.cover,
                            placeholder: "assets/man.png",
                              image: CacheHelper.getData(key: "photo"),
                            imageErrorBuilder: (context,o,c)=>ClipOval(
                              child: Image.asset(
                                "assets/man.png",
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: 4.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: MyTheme.mainAppBlueColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(CacheHelper.getData(key: "name"),style: TextStyle(color: Colors.white,fontSize: 18),)
              ],
            ),
          ),
         ListTile(
            leading: Icon(
              Icons.home,
              color: MyTheme.mainAppBlueColor,
            ),
            title: Text(
              "الصفحه الرئيسية",
              style: TextStyle(
                  color: MyTheme.mainAppBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: MyTheme.mainAppBlueColor,
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=>HomeScreen())
                  , (route) => false);
            },
          ),
          CacheHelper.getData(key: "token") != null ?ListTile(
            leading: Icon(
              Icons.person,
              color: MyTheme.mainAppBlueColor,
            ),
            title: Text(
              "الصفحة الشخصية",
              style: TextStyle(
                  color: MyTheme.mainAppBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: MyTheme.mainAppBlueColor,
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage())),
          ):
          SizedBox(),
          ListTile(
            leading: Icon(
              Icons.mail_outline,
              color: MyTheme.mainAppBlueColor,
            ),
            title: Text(
              "خدمة العملاء",
              style: TextStyle(
                  color: MyTheme.mainAppBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: MyTheme.mainAppBlueColor,
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerService())),
          ),
          CacheHelper.getData(key: "token") != null ?
          ListTile(
            leading: Icon(
              Icons.mail_outline,
              color: MyTheme.mainAppBlueColor,
            ),
            title: Text(
              "خدمات مجانية",
              style: TextStyle(
                  color: MyTheme.mainAppBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: MyTheme.mainAppBlueColor,
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FreeServiceScreen())),
          ):
          SizedBox(),
          ListTile(
            leading: Icon(
              Icons.rule_outlined,
              color: MyTheme.mainAppBlueColor,
            ),
            title: Text(
              "الشروط والسياسة",
              style: TextStyle(
                  color: MyTheme.mainAppBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: MyTheme.mainAppBlueColor,
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsAndPolicies())),
          ),
          CacheHelper.getData(key: "token") == null?
            ListTile(
              leading: Icon(
                Icons.login,
                color: MyTheme.mainAppBlueColor,
              ),
              title: Text(
                "دخول التطبيق",
                style: TextStyle(
                    color: MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: MyTheme.mainAppBlueColor,
              ),
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (c) => false),
            ):
          ListTile(
              leading: Icon(
                Icons.logout,
                color: MyTheme.mainAppBlueColor,
              ),
              title: Text(
                "خروج من التطبيق",
                style: TextStyle(
                    color: MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: MyTheme.mainAppBlueColor,
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (c) => false);
                CacheHelper.removeData(key: "token");
              }),
        ],
      ),
    );
  }
}
