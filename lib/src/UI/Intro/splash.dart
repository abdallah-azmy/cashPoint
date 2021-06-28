import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/Intro/loginType.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreenCashier.dart';
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


class SplashScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;
  SplashScreen({Key key, this.navigator}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  bool loggedIn;
//  bool firstOpen;
  var settings ;
  var logo ;
  var logInType ;


  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = _prefs.getBool("loggedIn");
//      firstOpen = _prefs.getBool("firstOpen");
      logo = _prefs.getString("logo");
      logInType = _prefs.getString("login");
    });

//    print("cheeeeeeeeeeeck $firstOpen");

    getSettings();

//    checkIfLoggedIn();

  }


  getSettings() async {
//    LoadingDialog(key, context).showLoadingDilaog();
    await ApiProvider(key, context)
        .getGeneralData()
        .then((value) async {
      if (value.code == 200) {

//        Navigator.pop(context);
      if(logo != value.data.logo ){
        _prefs.setString('logo', value.data.logo);
        setState(() {
          logo = value.data.logo ;
        });
      }

      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        LoadingDialog(key, context).showNotification(value.error[0].value);
      }
      checkIfLoggedIn();
    });
  }

  checkIfLoggedIn() async {
    Future.delayed(const Duration(seconds: 1,milliseconds: 200), () {

//      if (firstOpen == null) {
//        _prefs.setBool("firstOpen",true);
//        Navigator.of(context).push(
//            MaterialPageRoute(builder: (context) => LoginTypeScreen()));
//      }else
//        if (loggedIn == true) {

//     if (firstOpen == null){
//       _prefs.setBool("firstOpen",true);
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => EditLanguage(fromSplash: "true",))) ;}else{

       logInType == "كاشير" ?
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => MainScreenCashier()))
           :
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => MainScreen()));

//     }

//      } else {
//        Navigator.of(context).pushReplacement(
//            MaterialPageRoute(builder: (context) => LoginTypeScreen()));
//      }
    });
  }

  @override
  void initState() {
    FirebaseNotifications().setUpFirebase(widget.navigator);
    _getShared();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[





          Align(
            alignment: Alignment.center,
            child:  CachedNetworkImage(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                localization.text("first_welcome"),
                style: MyColors.styleBoldSmallWhite,
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                localization.text("cashpoint application"),
                style: MyColors.styleBoldOrange,
              ),
            ),
          )

        ],
      ),
    ));
  }
}
