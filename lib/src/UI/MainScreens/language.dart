//import 'package:ntaqat/src/MyColors.dart';
//import 'package:ntaqat/src/UI/Intro/splash.dart';
//import 'package:ntaqat/src/UI/MainScreens/MainScreen.dart';
//import 'package:ntaqat/src/UI/MainWidgets/Special_Button.dart';
//import 'package:ntaqat/src/UI/MainWidgets/selectCard.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//
//import 'package:ntaqat/src/firebaseNotification/appLocalization.dart';
////import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
////import '../../../../app.dart';
//
//class EditLanguage extends StatefulWidget {
//  final fromOut ;
//  EditLanguage({this.fromOut});
//  @override
//  _EditLanguageState createState() => _EditLanguageState();
//}
//
//class _EditLanguageState extends State<EditLanguage> {
//  List<CategoryModel> _countries = [];
//  List<CategoryModel> _lang = [];
////  GetCountriesModel getCountriesModel;
//  SharedPreferences _prefs;
//
//  getShared() async {
//    _prefs = await SharedPreferences.getInstance();
//  }
//
//  @override
//  void initState() {
//    super.initState();
//
//    _lang.add(new CategoryModel(
//        id: 1, label: 'العربية', image: 'assets/AR.png', selected: false));
//    _lang.add(new CategoryModel(
//      id: 2,
//      label: 'English',
//      selected: false,
//      image: 'assets/EN.png',
//
//    ));
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Directionality(
//      textDirection: localization.currentLanguage.toString() == "en"
//          ? TextDirection.ltr
//          : TextDirection.rtl,
//      child: Scaffold(
//        backgroundColor: Color(0xfff7f7f7),
//        appBar:
//        AppBar(
//          automaticallyImplyLeading: false,
//          centerTitle: true,
//          elevation: 0,
//          title: Text(
//            localization.text("language"),
//            style: MyColors.styleNormal2white,
//          ),
//          leading: widget.fromOut != null ? Container() : InkWell(
//            onTap: () {
//              return  Navigator.pushAndRemoveUntil(context,
//                  MaterialPageRoute(
//                      builder: (_)=> MainScreen()
//                  ), (route) => false);
//
//            },
//            child: Container(
//                color: Colors.transparent,
//                child: Icon(
//                  Icons.arrow_back_ios,
//                  color: Colors.white,
//                  size: 20,
//                )),
//          ),
//
//          actions: <Widget>[
//
//
//            SizedBox(
//              width: 20,
//            )
//          ],
//          backgroundColor: MyColors.blue,
//        ),
//
//        body:
//
//        WillPopScope(
//          onWillPop: (){
//            return widget.fromOut == null ?
//
//            Navigator.pushAndRemoveUntil(context,
//                MaterialPageRoute(
//                    builder: (_)=> MainScreen()
//                ), (route) => false)
//                :
//            false ;
//          },
//          child: Directionality(
//            textDirection: localization.currentLanguage.toString() == "en"
//                ? TextDirection.rtl
//                : TextDirection.ltr,
//            child: ListView(
//              children: <Widget>[
//                SizedBox(height: 50),
//
//
//                Padding(
//                  padding: const EdgeInsets.only(right: 10, left: 10),
//                  child: Text(localization.text("choose_lang"),
//                      textDirection: localization.currentLanguage.toString() == "en"
//                          ? TextDirection.ltr
//                          : TextDirection.rtl,
//                      style: TextStyle(
//                          color: Colors.black, fontWeight: FontWeight.bold)),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 10.0, left: 10),
//                  child: Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.white,
//                    ),
//                    child: SelectCard(
//                      list: _lang,
//                      title: "language",
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
//                  child:
//                  SpecialButton(
//                    onTap: () {
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          MaterialPageRoute(builder: (context) => SplashScreen()),
//                              (Route<dynamic> route) => false);
//                    },
//                    text: localization.text("save"),
//                  ),
//
//
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
