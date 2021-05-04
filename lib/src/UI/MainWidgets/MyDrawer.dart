//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
//import 'package:cashpoint/src/LoadingDialog.dart';
//import 'package:cashpoint/src/MyColors.dart';
//import 'package:cashpoint/src/UI/Authentication/login.dart';
//import 'package:cashpoint/src/UI/Intro/splash.dart';
//import 'package:cashpoint/src/UI/MainScreens/AppLinks.dart';
//import 'package:cashpoint/src/UI/MainScreens/ContactUs.dart';
//import 'package:cashpoint/src/UI/MainScreens/MainScreen.dart';
//
//import 'package:cashpoint/src/UI/MainScreens/MyLocations.dart';
//import 'package:cashpoint/src/UI/MainScreens/MyProfile.dart';
//import 'package:cashpoint/src/UI/MainScreens/language.dart';
//import 'package:cashpoint/src/UI/MainWidgets/Drawer_Item.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class MyDrawer extends StatefulWidget {
//
//  final currentScreen;
//  final bottomNavigationKey;
//  final scaffold;
//  MyDrawer({ this.currentScreen,this.scaffold,this.bottomNavigationKey});
//
//  @override
//  _MyDrawerState createState() => _MyDrawerState();
//}
//
//class _MyDrawerState extends State<MyDrawer> {
////  var nameAr;
//  var name;
//  var profileImage;
//  var apiToken;
//  bool show = false;
//  SharedPreferences _prefs;
//  bool isItBranch = false ;
//
//  _getShared() async {
//
//    _prefs = await SharedPreferences.getInstance();
//    setState(() {
//      profileImage = _prefs.getString("image");
//      name = _prefs.getString("name");
////      nameAr = _prefs.getString("nameAr");
//      apiToken = _prefs.getString("api_token");
//      print(">>>>>>>>>>>>>>>>>>>>>>> $apiToken");
//    });
//
//  }
//
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _getShared();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//      child: Directionality(
//        textDirection: localization.currentLanguage.toString() == "en"
//            ? TextDirection.ltr
//            : TextDirection.rtl,
//        child: ListView(
//          children: [
//            Container(
//              height: 180,
//              color: MyColors.blue,
//              child: DrawerHeader(
//                  decoration: BoxDecoration(color: MyColors.blue,),
//                  child: InkWell(
//                    onTap: () {
//                      if (widget.currentScreen != 0) {
//                        Navigator.pop(context);
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (BuildContext context) => MyProfile()));
//
//
//
//                      } else {
//                        Navigator.pop(context);
//                      }
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.only(right: 10),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            height: 100,
//                            width: 100,
//                            child: ClipOval(
//                              child: CachedNetworkImage(
//                                fit: BoxFit.cover,
//                                imageUrl: "$profileImage",
//                                placeholder: (context, url) => new Container(
//                                  color: MyColors.grey,
//                                  child: CircularProgressIndicator(),
//                                ),
//                                errorWidget: (context, url, error) => new Container(
//                                  color: MyColors.grey,
//                                ),
//                              ),
//                            ),
//                          ),
////                      CircleAvatar(
////                        radius: 45,
////                        child: Image.asset(
////                          "assets/icon/albik.png",
////                        ),
////                        backgroundColor: Colors.white,
////                      ),
//                          SizedBox(
//                            width: 20,
//                          ),
//                          Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text("${localization.text("welcome_user")}",style: MyColors.styleNormalWhite,),
//                              Flexible(
//                                child: Text(
//                                  "$name" ,
//                                  style: MyColors.styleNormal2white,
//                                ),
//                              ),
//                            ],
//                          )
//                        ],
//                      ),
//                    ),
//                  )),
//            ),
//            Column(
//              children: <Widget>[
//                SizedBox(
//                  height: 8,
//                ),
//                DrawerItem(
//                  onTap: () {
//                    if (widget.currentScreen != 1) {
//                      Navigator.pop(context);
//                    Navigator.pushReplacement(
//                        context, MaterialPageRoute(builder: (BuildContext context) => MainScreen(neededScreen: 1,)));
//
//                    } else {
//                      Navigator.pop(context);
//                      final FancyBottomNavigationState fState =
//                          widget.bottomNavigationKey.currentState;
//                      fState.setPage(1);
//                    }
//                  },
//                  text:  localization.text("centers"),
//                ),
//
//                Divider(height: 5,),
//
//                DrawerItem(
//                  onTap: () {
//                    if (widget.currentScreen != 0) {
//                      Navigator.pop(context);
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (BuildContext context) => MyProfile()));
//
//
////                      Navigator.push(
////                          context,
////                          new MaterialPageRoute(
////                              builder: (BuildContext context) =>
////                                  MyRestaurant()));
//                    } else {
//                      Navigator.pop(context);
//                    }
//                  },
//                  text: localization.text("profile"),
//                ),
//                Divider(height: 5,),
////
////                Column(
////                  children: <Widget>[
////
////
////
////                    DrawerItem(
////                      onTap: () {
////                        if (widget.currentScreen != 1) {
////                          Navigator.pop(context);
////                          Navigator.pushReplacement(
////                              context, MaterialPageRoute(builder: (BuildContext context) => MainScreen(neededScreen: 2,)));
//////
////                        } else {
////                          Navigator.pop(context);
////                          final FancyBottomNavigationState fState =
////                              widget.bottomNavigationKey.currentState;
////                          fState.setPage(2);
////                        }
////                      },
////                      text: localization.text("my orders"),
////                    ),
////                    Divider(height: 5,),
////                  ],
////                ),
//
////                  Column(
////                  children: <Widget>[
////                    DrawerItem(
////                      onTap: () {
////                        if (widget.currentScreen != 1) {
////                          Navigator.pop(context);
////                       Navigator.pushReplacement(
////                              context, MaterialPageRoute(builder: (BuildContext context) => MainScreen(neededScreen: 0,)));
////                        } else {
////                          Navigator.pop(context);
////                          final FancyBottomNavigationState fState =
////                              widget.bottomNavigationKey.currentState;
////                          fState.setPage(0);
////                        }
////                      },
////                      text: localization.text("_notifications"),
////                    ),
////                    Divider(height: 5,),
////                  ],
////                ),
//                Column(
//                  children: <Widget>[
//                    DrawerItem(
//                      onTap: () {
//                        if (widget.currentScreen != 10) {
//                          Navigator.pop(context);
//                        Navigator.pushReplacement(
//                            context, MaterialPageRoute(builder: (BuildContext context) => MyLocations()));
//
//
////                    Navigator.push(
////                        context,
////                        new MaterialPageRoute(
////                            builder: (BuildContext context) => Additions()));
//                        } else {
//                          Navigator.pop(context);
//                        }
//                      },
//                      text: localization.text("delivery locations"),
//                    ),
//                    Divider(height: 5,),
//                  ],
//                ),
//
//                DrawerItem(
//                  onTap: () {
//                    if (widget.currentScreen != 101) {
//                      Navigator.pop(context);
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (BuildContext context) => AppLinks()));
//                    } else {
//                      Navigator.pop(context);
//                    }
//                  },
//                  text: localization.text("Application links"),
//                ),
//                Divider(height: 5,),
//
//                DrawerItem(
//                  onTap: () {
//                    if (widget.currentScreen != 6) {
//                      Navigator.pop(context);
////                    Navigator.pushReplacement(
////                        context, MaterialPageRoute(builder: (BuildContext context) => Orders()));
////                    Navigator.push(
////                        context,
////                        new MaterialPageRoute(
////                            builder: (BuildContext context) => Orders()));
//                    } else {
//                      Navigator.pop(context);
//                    }
//                  },
//                  text: localization.text("share application"),
//                ),
//                Divider(height: 5,),
//                Column(
//                  children: <Widget>[
//                    DrawerItem(
//                      onTap: () {
//                        if (widget.currentScreen != 7) {
//                          Navigator.pop(context);
//                        Navigator.pushReplacement(
//                            context, MaterialPageRoute(builder: (BuildContext context) => ContactUs()));
//
////                    Navigator.push(
////                        context,
////                        new MaterialPageRoute(
////                            builder: (BuildContext context) => Shifts()));
//                        } else {
//                          Navigator.pop(context);
//                        }
//                      },
//                      text: localization.text("call us"),
//                    ),
//                    Divider(height: 5,),
//
//                  ],
//                ),
//
//                Column(
//                  children: <Widget>[
//                    DrawerItem(
//                      onTap: () {
//
//                          Navigator.pop(context);
//                          Navigator.pushReplacement(
//                              context, MaterialPageRoute(builder: (BuildContext context) => EditLanguage()));
//
//                      },
//                      text: localization.text("choose_lang"),
//                    ),
//                    Divider(height: 5,),
//                  ],
//                ),
//
//
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
//                  child: InkWell(
//                    onTap: () {
//                      LoadingDialog(widget.scaffold, context)
//                          .logOutAlert(localization.text("do you want to logOut ?"),(){
//                        _prefs.clear();
//                        Navigator.of(context).pushAndRemoveUntil(
//                            MaterialPageRoute(builder: (context) => SplashScreen()),
//                                (Route<dynamic> route) => false);
//                      });
//
//                    },
//                    child: Container(
//                      height: 35,
//                      child: Row(
//                        children: <Widget>[
//                          Text(
//                            localization.text("logOut"),
//                            style:  TextStyle(color: Colors.red[900],
//                                fontSize: 19,
//                                // fontFamily: "Tajawal",
//                                fontWeight: FontWeight.w500),
//                          ),
//                        ],
//                      ),
//                    ),
//
//                  ),
//                ),
//
//
//
//
//
//
//                SizedBox(height: 30),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
