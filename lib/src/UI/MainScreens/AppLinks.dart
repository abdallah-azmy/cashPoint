//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
//import 'package:ntaqat/src/LoadingDialog.dart';
//import 'package:ntaqat/src/MyColors.dart';
//import 'package:ntaqat/src/Network/api_provider.dart';
//import 'package:ntaqat/src/UI/Authentication/login.dart';
//import 'package:ntaqat/src/UI/MainWidgets/Edit_Text_Field.dart';
//import 'package:ntaqat/src/UI/MainWidgets/MyDrawer.dart';
//import 'package:ntaqat/src/UI/MainWidgets/Special_Button.dart';
//import 'package:flutter/material.dart';
//import 'package:ntaqat/src/UI/MainWidgets/mapPositionFromLatLon.dart';
//import 'package:ntaqat/src/firebaseNotification/appLocalization.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:url_launcher/url_launcher.dart';
//
//import 'MainScreen.dart';
//class AppLinks extends StatefulWidget {
//  @override
//  _AppLinksState createState() => _AppLinksState();
//}
//
//class _AppLinksState extends State<AppLinks> {
//  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
//  SharedPreferences _prefs;
//  var apiToken;
//  var details;
//
//
//  _getShared() async {
//    _prefs = await SharedPreferences.getInstance();
//    setState(() {
//      apiToken = _prefs.getString("api_token");
//    });
//    getData();
//    print("api_token >>>>> $apiToken");
//  }
//
//  getData() async {
//    LoadingDialog(key, context).showLoadingDilaog();
//    await ApiProvider(key, context).qrCode().then((value) async {
//      if (value.code == 200) {
//        Navigator.pop(context);
//
//        setState(() {
//          details = value.data[0];
//        });
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        LoadingDialog(key, context).showNotification(value.error[0].value);
//      }
//    });
//  }
//
//
//
//  @override
//  void initState() {
//    super.initState();
//    _getShared();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Directionality(
//      textDirection: localization.currentLanguage.toString() == "en"
//          ? TextDirection.ltr
//          : TextDirection.rtl,
//      child: Scaffold(
//        key: key,
//        drawer: MyDrawer(
//          currentScreen: 101,
//          scaffold: key,
//        ),
//        backgroundColor: Color(0xfff7f7f7),
////        bottomNavigationBar: Padding(
////          padding:
////          const EdgeInsets.only(left: 65, right: 65, bottom: 10, top: 0),
////          child: SpecialButton(
////            onTap: () {
////              contactUs();
////            },
////            text: localization.text("send"),
////          ),
////        ),
//        appBar: AppBar(
//          centerTitle: true,
//          elevation: 0,
//          title: Text(
//            localization.text("Application links"),
//            style: MyColors.styleNormal2white,
//          ),
//          leading: InkWell(
//            onTap: () {
//              key.currentState.openDrawer();
//            },
//            child: Container(
//                height: 30,
//                width: 30,
//                child: Center(
//                    child: Image.asset(
//                      "assets/list.png",
//                      height: 22,
//                      width: 22,
//                      color: Colors.white,
//                    ))),
//          ),
//          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(left: 15, right: 15),
//              child: InkWell(
//                onTap: () {
//                  Navigator.pushAndRemoveUntil(
//                      context,
//                      MaterialPageRoute(builder: (_) => MainScreen()),
//                          (route) => false);
//                },
//                child: Container(
//                  height: 30,
//                  width: 30,
//                  child: Icon(
//                    Icons.arrow_forward_ios,
//                    size: 20,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//            ),
//          ],
//          backgroundColor: MyColors.blue,
//        ),
//        body: WillPopScope(
//          onWillPop: () {
//            return Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (_) => MainScreen()),
//                    (route) => false);
//          },
//          child: SingleChildScrollView(
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 25),
//              child: Center(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 20,
//                    ),
//
//
//
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Text(
//                        "${localization.text("for employee")} :",
//                        style: MyColors.styleBold2,
//                      ),
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//
//                    details == null ? Container(height: 150,
//                      width: 150,) : Container(
//                      height: 150,
//                      width: 150,
//                      child: CachedNetworkImage(
//                        imageUrl: "${details.qrcodeEmployee}",
//                        errorWidget: (context, url, error) =>
//                        new Icon(Icons.error),
//                        placeholder: (context, url) => new Container(
//                          height: 50,
//                          width: 50,
//                          child: Center(child: CircularProgressIndicator()),
//
//                        ),),
//
//                    ),
//
//
//                    SizedBox(height: 35,),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Text(
//                        "${localization.text("for clients")} :",
//                        style: MyColors.styleBold2,
//                      ),
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//
//                    details == null ? Container(height: 150,
//                      width: 150,) : Container(
//                      height: 150,
//                      width: 150,
//                      child: CachedNetworkImage(
//                        imageUrl: "${details.qrcodeClient}",
//                        errorWidget: (context, url, error) =>
//                        new Icon(Icons.error),
//                        placeholder: (context, url) => new Container(
//                          height: 50,
//                          width: 50,
//                          child: Center(child: CircularProgressIndicator()),
//
//                        ),),
//
//                    )
//
//
//
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
