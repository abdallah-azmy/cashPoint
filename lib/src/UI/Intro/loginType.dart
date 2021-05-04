import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/HomeScreen.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreen.dart';
import 'package:cashpoint/src/UI/MainScreens/language.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:cashpoint/src/firebaseNotification/firebaseNotifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginTypeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginTypeScreenState();
  }
}

class LoginTypeScreenState extends State<LoginTypeScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  SharedPreferences _prefs;
  var logo ;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      logo = _prefs.getString("logo");
    });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
      _getShared();

  }




  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: key,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/cashpoint/Nbackground.png",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),

                ListView(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .22,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        width: 209,
                        height: 146,
                        fit: BoxFit.fill,
//              color: Colors.transparent,
                        imageUrl: logo == null
                            ? " "
                            : "$logo",
                        placeholder: (context, url) => new Container(
                          height: 30,
                          width: 30,
//                                      color: MyColors.grey,
                          child: Center(
                              child: SpinKitChasingDots(
                                color: Colors.white,
                                size: 30.0,
                              )),
                        ),
                        placeholderFadeInDuration:
                        Duration(milliseconds: 500),
                        errorWidget: (context, url, error) =>
                        new Container(
                          height: 30,
                          width: 30,
                          child: Center(
                              child: SpinKitChasingDots(
                                color: Colors.white,
                                size: 30.0,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                localization.text("Choose the type of register"),
                                style: MyColors.styleNormal2yellow,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),



                          SpecialButton(
                            onTap: () async {



//                                login();
                              _prefs.setString('login', "عميل");

//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => MainScreen()));

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => MainScreen()),
                                      (route) => false);



//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => LoginPage()));
                            },
                            text: localization.text("customer"),
                            color: MyColors.orange,
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SpecialButton(
                            onTap: () async {

                              _prefs.setString('login', "متجر");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPage()));

                            },
                            text:  localization.text("store"),
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

//              InkWell(
//                onTap: () => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => SignUpPage())),
//                child: Text(
//                  localization.text("sign_up"),
//                  style: TextStyle(
//                      fontSize: 15,
//                      fontFamily: "RB",
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white),
//                  textAlign: TextAlign.center,
//                ),
//              ),

                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
