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
import 'taps/HomeScreen.dart';
//import 'taps/Notifications.dart';

GlobalKey<NotificationsState> globalKey = GlobalKey();

class MainScreen extends StatefulWidget {
  var neededScreen;
  MainScreen({this.neededScreen});
  @override
  _MainScreenState createState() => _MainScreenState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class _MainScreenState extends State<MainScreen> {
//  int navPos = 2;

  var _bottomNavIndex = 2;

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

  List<Widget> widgets = [
    Notifications(
      scaffold: _key,
      key: globalKey,
//                token: apiToken,
    ),

    MyProfile(
      scaffold: _key,
    ),
//    logInType == "متجر" ? MyHomeForStore(
//      scaffold: _key,
//    ) :
    HomeScreen(
      scaffold: _key,
    ),
    MyOrders(
      scaffold: _key,
    ),

    Settings(
      scaffold: _key,
    ),
  ];

  List<Widget> widgetsForStore = [
    Notifications(
      scaffold: _key,
      key: globalKey,
//                token: apiToken,
    ),

    MyProfile(
      scaffold: _key,
    ),
//    logInType == "متجر" ?
    MyHomeForStore(
      scaffold: _key,
    ),
//    :
//    HomeScreen(
//      scaffold: _key,
//    ),
    MyOrders(
      scaffold: _key,
    ),

    Settings(
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
            logInType == "loading" ? Container() :    logInType == null ? widgets[widget.neededScreen ?? _bottomNavIndex]:
                logInType == "متجر"
                ? widgetsForStore[widget.neededScreen ?? _bottomNavIndex]
                : widgets[widget.neededScreen ?? _bottomNavIndex],
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
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/cashpoint/profile2.png",
                        height: 21,
                        width: 21,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        localization.text("profile"),
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
                      logInType == "loading" ? Container() :   logInType == "متجر"
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

//      logInType == "متجر" ? widgetsForStore[widget.neededScreen ?? _bottomNavIndex] : widgets[ widget.neededScreen ?? _bottomNavIndex],
//        bottomNavigationBar:

//      body:
//      loading == true ? Center(child: CircularProgressIndicator(),) :
//      Stack(
//        children: [
//          IndexedStack(
//            index: navPos,
//            children: [
//              Notifications(
//                scaffold: _key,
//                key: globalKey,
////                token: apiToken,
//              ),
//
//              MyProfile(
//                  scaffold: _key,
//                ),
//              logInType == "متجر" ? MyHomeForStore(
//                scaffold: _key,
//              ) :  HomeScreen(
//                  scaffold: _key,
//                ),
//              MyOrders(
//                  scaffold: _key,
//                ),
//
//              Settings(
//                scaffold: _key,
//              ),
//            ],
//          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: CurvedBottomNavigation(
//              selected: navPos,
//              bgColor: Colors.white,navHeight: 70.0,
//              fabBgColor: Colors.grey[300],
//              fabMargin: 11.0,
//
//              onItemClick: (i) {
//                setState(() {
//                  navPos = i;
//                });
//              },
//              items: [
//                InkWell(
//                  onTap: (){
////                    Future.delayed(Duration(milliseconds: 250),(){
////                      NotificationsState().delayedFun() ;
////                    });
////                    NotificationsState().getShared() ;
//                    print("yaaaa");
//                  },
//                  child: Container(child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
////                    Icon(Icons.notifications_none, color: Colors.black),
//                      Image.asset(
//                        "assets/cashpoint/bill2.png",
//                        fit: BoxFit.fill,
//                        height: 21,
//                        width: 21,
//                      ),
//                      SizedBox(height: 2,),
//                      Text(localization.text("_notifications"),textAlign: TextAlign.center,style: MyColors.styleNormalSmal3,),
//                    ],
//                  )),
//                ),
//                Container(child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    Image.asset(
//                      "assets/cashpoint/profile2.png",
//                      height: 21,
//                      width: 21,
//                      fit: BoxFit.fill,
//                    ),
//                    SizedBox(height: 2,),
//                    Text(localization.text("profile"),textAlign: TextAlign.center,style: MyColors.styleNormalSmal3,),
//                  ],
//                )),
//
//                Container(child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Image.asset(
//                      "assets/cashpoint/home2.png",
//                      fit: BoxFit.fill,
//                      height: 26,
//                      width: 26,
//                      color: Colors.black26,
//                    ),
////                    Text(localization.text("_my orders"),style: MyColors.styleNormalSmal2,),
//                  ],
//                )),
//
//                Container(child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Image.asset(
//                      "assets/cashpoint/cart2.png",
//                      fit: BoxFit.fill,
//                      height: 21,
//                      width: 21,
//                    ),
//                    SizedBox(height: 2,),
//                    logInType == "متجر" ? Text(localization.text("My sales"),textAlign: TextAlign.center,style: MyColors.styleNormalSmal3,) : Text(localization.text("My purchases"),textAlign: TextAlign.center,style: MyColors.styleNormalSmal3,),
//                  ],
//                )),
//
//
//                Container(child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Image.asset(
//                      "assets/cashpoint/settings2.png",
//                      fit: BoxFit.fill,
//                      height: 21,
//                      width: 21,
//                    ),
//                    SizedBox(height: 2,),
//                    Text(localization.text("settings"),
//                      textAlign: TextAlign.center,style: MyColors.styleNormalSmal3,),
//                  ],
//                )),
//
//
//
//              ],
//            ),
//          ),
//        ],
//      ),
        );
  }
}
