import 'package:cashpoint/src/UI/MainScreens/Cashier/MyHomeForCashier.dart';
import 'package:cashpoint/src/UI/MainScreens/Cashier/MyProfileCashier.dart';
import 'package:cashpoint/src/UI/MainScreens/Cashier/NotificationsCashier.dart';
import 'package:cashpoint/src/UI/MainScreens/Cashier/SettingsCashier.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyHomeForStore.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyProfile.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/Notifications.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/Settings.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyOrders.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MyColors.dart';
import '../../firebaseNotification/appLocalization.dart';
import 'Cashier/MyOrdersCashier.dart';
import 'taps/HomeScreen.dart';
//import 'taps/Notifications.dart';

GlobalKey<NotificationsState> globalKey = GlobalKey();

class MainScreenCashier extends StatefulWidget {
  var neededScreen;
  MainScreenCashier({this.neededScreen});
  @override
  _MainScreenCashierState createState() => _MainScreenCashierState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class _MainScreenCashierState extends State<MainScreenCashier> {
//  int navPos = 2;

  var _bottomNavIndex = 1;

  SharedPreferences _prefs;
  var apiToken;
  var logInType = "loading";
  var loading = true;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      loading = false;
    });
    print("api_token >>>>> $apiToken");
  }


  List<Widget> widgetsForCashier = [
    NotificationsCashier(
      scaffold: _key,
      key: globalKey,
    ),
    MyHomeForCashier(
      scaffold: _key,
    ),
    MyOrdersCashier(
      scaffold: _key,
    ),
    SettingsCashier(
      scaffold: _key,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getShared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
             widgetsForCashier[widget.neededScreen ?? _bottomNavIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedBottomNavigation(
                selected: widget.neededScreen ?? _bottomNavIndex,
                bgColor: Colors.white,
                navHeight: 70.0,
                fabBgColor: Colors.grey[300],
                fabMargin: 11.0,
                onItemClick: (i) {
                  setState(() {
//              navPos = i;
//              setState(() {
                    _bottomNavIndex = i;
                    widget.neededScreen = _bottomNavIndex;
//              });
                  });
                },
                items: [
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
//                    Icon(Icons.notifications_none, color: Colors.black),
                      Image.asset(
                        "assets/cashpoint/bill2.png",
                        fit: BoxFit.fill,
                        height: 21,
                        width: 21,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        localization.text("_notifications"),
                        textAlign: TextAlign.center,
                        style: MyColors.styleNormalSmal3,
                      ),
                    ],
                  )),
//                  Container(
//                      child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                      Image.asset(
//                        "assets/cashpoint/profile2.png",
//                        height: 21,
//                        width: 21,
//                        fit: BoxFit.fill,
//                      ),
//                      SizedBox(
//                        height: 2,
//                      ),
//                      Text(
//                        localization.text("profile"),
//                        textAlign: TextAlign.center,
//                        style: MyColors.styleNormalSmal3,
//                      ),
//                    ],
//                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/cashpoint/home2.png",
                        fit: BoxFit.fill,
                        height: 26,
                        width: 26,
                        color: Colors.black26,
                      ),
//                    Text(localization.text("_my orders"),style: MyColors.styleNormalSmal2,),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/cashpoint/cart2.png",
                        fit: BoxFit.fill,
                        height: 21,
                        width: 21,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      logInType == "loading" ? Container() :   (logInType == "????????" || logInType == "??????????")
                          ? Text(
                              localization.text("My sales"),
                              textAlign: TextAlign.center,
                              style: MyColors.styleNormalSmal3,
                            )
                          : Text(
                              localization.text("My purchases"),
                              textAlign: TextAlign.center,
                              style: MyColors.styleNormalSmal3,
                            ),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/cashpoint/settings2.png",
                        fit: BoxFit.fill,
                        height: 21,
                        width: 21,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        localization.text("settings"),
                        textAlign: TextAlign.center,
                        style: MyColors.styleNormalSmal3,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        )

        );
  }
}
