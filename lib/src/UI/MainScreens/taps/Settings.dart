import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/Intro/splash.dart';
import 'package:cashpoint/src/UI/MainScreens/Advertisment.dart';
import 'package:cashpoint/src/UI/MainScreens/ContactUs.dart';

import 'package:cashpoint/src/UI/MainScreens/EditProfile.dart';
import 'package:cashpoint/src/UI/MainScreens/MyCashiers.dart';
import 'package:cashpoint/src/UI/MainScreens/MyCommissions.dart';
import 'package:cashpoint/src/UI/MainScreens/MyPayments.dart';
import 'package:cashpoint/src/UI/MainScreens/About.dart';
import 'package:cashpoint/src/UI/MainScreens/Slider.dart';
import 'package:cashpoint/src/UI/MainScreens/Suggestions.dart';
import 'package:cashpoint/src/UI/MainScreens/language.dart';
import 'package:cashpoint/src/UI/MainWidgets/Settings_Row.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  final scaffold;
  Settings({
    this.scaffold,
  });
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var profileImage =
      "https://homepages.cae.wisc.edu/~ece533/images/peppers.png";

  SharedPreferences _prefs;
  String _deviceToken;
  var apiToken;
  var details;
  var name;
  var imgFromCach;
  var logInType;
  var loadingToken = true;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    _deviceToken = await _firebaseMessaging.getToken();
    setState(() {
      apiToken = _prefs.getString("api_token");
      name = _prefs.getString("name");
      imgFromCach = _prefs.getString("image");
      logInType = _prefs.getString("login");
      loadingToken = false;
    });

    print("33333333333333333333 $imgFromCach");
    apiToken == null
        ? print("no token")
        : logInType == "متجر"
            ? getData()
            : getDataForClient();
  }

  getData() async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .getAllDataForStore(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data;
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
      }
    });
  }

  getDataForClient() async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .getAllDataForClient(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data;
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
      }
    });
  }

  logOut() async {
    Navigator.pop(context);
    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .logOutService(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct logOut");
//        Navigator.pop(context);
//
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) => SplashScreen()),
//            (Route<dynamic> route) => false);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
      }
    });

    await ApiProvider(_scafold, context)
        .logOut(apiToken: apiToken, device_token: _deviceToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct logOut");
        Navigator.pop(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (Route<dynamic> route) => false);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getShared();
  }

  @override
  Widget build(BuildContext context) {
    return loadingToken == true
        ? Container()
        : apiToken == null
            ? LoginPage()
            : Directionality(
                textDirection: localization.currentLanguage.toString() == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Scaffold(
                    key: _scafold,
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Color(0xfff5f6f8),
                    body: SafeArea(
                      child: ListView(
                        children: <Widget>[
//
                          Container(
                            decoration: BoxDecoration(color: MyColors.darkRed),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9, right: 10, left: 10),
                                        child: Text(
                                          localization.text("settings"),
                                          style: MyColors.styleBold2white,
                                        )),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          CachedNetworkImage(
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.fill,
                                            imageUrl:
//                                            details == null
//                                                ? " "
//                                                : logInType == "متجر"
//                                                    ? details.logo == null
//                                                        ? " "
//                                                        : "${details.logo}"
//                                                    : details.image == null
//                                                        ? " "
//                                                        : "${details.image}",
                                                "$imgFromCach"
//                                                  != null ? " " : "$imgFromCach"
                                            ,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10000.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10000.0),
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                new Container(
                                              height: 80,
                                              width: 80,
//                                      color: MyColors.grey,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                            placeholderFadeInDuration:
                                                Duration(milliseconds: 500),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 80,
                                              width: 80,
//                                      color: MyColors.grey,
                                              child: Center(
                                                  child: Icon(
                                                Icons.error,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                            ),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    ClipRRect(
//                                              borderRadius:
//                                                  BorderRadius.circular(
//                                                      10000.0),
//                                              child: new Container(
//                                                height: 80,
//                                                width: 80,
////                                                color: MyColors.grey,
//                                              ),
//                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9, right: 10, left: 10),
                                        child: Text(
                                          localization.text("settings"),
                                          style: TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 18,
                                              // fontFamily: "Tajawal",
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      localization.text("welcome_user"),
                                      style: MyColors.styleBold4white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
//                                                details == null
//                                                    ? " "
//                                                    : details.name == null
//                                                        ? " "
//                                                        : "${details.name}",
                                        name == null ? "" : "$name",
                                        style: MyColors.styleBold4white,
                                      ),
                                    ),
                                  ],
                                ),
                                logInType == "متجر"
                                    ? Container()
                                    : Text(
                                        details == null
                                            ? " "
                                            : details.email == null
                                                ? " "
                                                : "${details.email}",
                                        style: MyColors.styleBoldOrangeSmall,
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: MyColors.darkRed,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: MyColors.darkRed,
                              borderRadius: BorderRadius.only(
//                        bottomLeft:  Radius.circular(80),
                                  ),
                            ),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f6f8),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(80),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                SettingsRow(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditProfile(
                                                  getData: () {
//                                                    logInType == "متجر"
//                                                        ? getData()
//                                                        : getDataForClient();
                                                    _getShared();
                                                  },
                                                )));
                                  },
                                  text: localization.text("edit profile"),
                                  icon: Image.asset(
                                    "assets/cashpoint/profile2.png",
                                    fit: BoxFit.cover,
                                    height: 22,
                                    width: 22,
                                  ),
                                ),
                                logInType == "متجر"
                                    ? Container()
                                    : SettingsRow(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Suggestions()));
                                        },
                                        text: localization.text("Suggestions"),
                                        icon: Icon(
                                          Icons.message,
                                          color: Colors.black38,
                                          size: 24,
                                        ),
                                      ),
                                if (logInType == "متجر")
                                  SettingsRow(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovingSlider()));
                                    },
                                    text: localization.text("slider"),
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.black54,
                                      size: 25,
                                    ),
                                  )
                                else
                                  Container(),
                                logInType == "متجر"
                                    ? SettingsRow(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyCashiers()));
                                        },
                                        text: localization.text("cashier"),
                                        icon: Icon(
                                          Icons.supervised_user_circle,
                                          color: Colors.black54,
                                          size: 25,
                                        ),
                                      )
                                    : Container(),
                                if (logInType == "متجر")
                                  SettingsRow(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Advertisements()));
                                    },
                                    text:
                                        localization.text("Advertise with us"),
                                    icon: Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.black54,
                                      size: 25,
                                    ),
                                  )
                                else
                                  Container(),
                                SettingsRow(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AboutUsTheApp()));
                                  },
                                  text: localization.text("about"),
                                  icon: Image.asset(
                                    "assets/cashpoint/quest2.png",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SettingsRow(
                                    onTap: () {},
                                    text: localization
                                        .text("rate the application"),
                                    icon: Icon(
                                      Icons.rate_review,
                                      color: Colors.black54,
                                      size: 23,
                                    )),
                                logInType == "متجر"
                                    ? SettingsRow(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyCommissions()));
                                        },
                                        text:
                                            localization.text("my commissions"),
                                        icon: Icon(
                                          Icons.attach_money,
                                          color: Colors.black54,
                                          size: 25,
                                        ))
                                    : Container(),
                                logInType == "متجر"
                                    ? SettingsRow(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyPayments()));
                                        },
                                        text: localization.text("My payments"),
                                        icon: Image.asset(
                                          "assets/cashpoint/wallet2.png",
                                          fit: BoxFit.fill,
                                          height: 22,
                                          width: 22,
                                        ),
                                      )
                                    : Container(),
                                SettingsRow(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ContactUs()));
                                  },
                                  text: localization.text("contact us"),
                                  icon: Image.asset(
                                    "assets/cashpoint/mobile2.png",
                                    fit: BoxFit.fill,
                                    height: 22,
                                    width: 22,
                                  ),
                                ),
                                SettingsRow(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditLanguage()));
                                    },
                                    text: localization.text("choose_lang"),
                                    icon: Icon(
                                      Icons.language,
                                      color: Colors.black54,
                                      size: 23,
                                    )),
                                InkWell(
                                    onTap: () {
                                      LoadingDialog(widget.scaffold, context)
                                          .logOutAlert(
                                              localization.text(
                                                  "do you want to logOut ?"),
                                              () {
                                        _prefs.clear();
                                        logOut();
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/cashpoint/logout2.png",
                                          fit: BoxFit.fill,
                                          height: 20,
                                          width: 25,
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          localization.text("logOut"),
                                          style: MyColors.styleNormal15Grey,
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 120,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
  }
}
