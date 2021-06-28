import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Intro/splash.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/selectCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:cashpoint/src/Models/getCountriesModel.dart';
//import 'package:cashpoint/src/Provider/getCountriesProvider.dart';

//import 'package:cashpoint/src/UI/MainWidgets/customBtn.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../../../../app.dart';
class EditLanguageCashier extends StatefulWidget {
  @override
  _EditLanguageCashierState createState() => _EditLanguageCashierState();
}

class _EditLanguageCashierState extends State<EditLanguageCashier> {
  List<CategoryModel> _countries = [];
  List<CategoryModel> _lang = [];
  List<CategoryModel> lang = [];
//  GetCountriesModel getCountriesModel;
  SharedPreferences _prefs;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var apiToken ;
  var langInInit ;
  getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      langInInit = localization.currentLanguage.toString();
    });
    print("apiToken:  $apiToken");
  }


  selectLanguage({lang}) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .changeLanguageCashier(apiToken: apiToken,language:lang )
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.message);
//
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }


  @override
  void initState() {
    super.initState();

    getShared();
    _lang.add(new CategoryModel(
        id: 1, label: 'العربية', image: 'assets/AR.png', selected: false));
    lang.add(new CategoryModel(
      id: 2,
      label: 'English',
      selected: false,
      image: 'assets/EN.png',

    ));
  }




  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        key: _key,
//        AppBar(
//          automaticallyImplyLeading: false,
//          centerTitle: true,
//          elevation: 0,
//          title: Text(
//            localization.text("language"),
//            style: MyColors.styleNormal2,
//          ),
//          leading: InkWell(
//            onTap: () {
//              Navigator.pop(context) ;
//            },
//            child: Container(
//                color: Colors.transparent,
//                child: Icon(
//                  Icons.arrow_back_ios,
//                  color: Colors.black,
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
//          backgroundColor: Colors.white,
////        flexibleSpace: Image(
////          image: AssetImage("assets/backgroun.jpg"),
////          fit: BoxFit.cover,
////        ),
//        ),

        body:

        ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        top: 9, right: 15, left: 15, bottom: 3),
                    child: Text(
                      localization.text("language"),
                      style: MyColors.styleBold2,
                    )),
                Padding(
                    padding:
                    const EdgeInsets.only(top: 7, right: 8, left: 8),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            )))),
              ],
            ),
            SizedBox(height: 50),


            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(localization.text("choose_lang"),
                  textDirection: localization.currentLanguage.toString() == "en"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Material( borderRadius: BorderRadius.circular(10),
                  color: Colors.white,elevation: 5,child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: ()async{


                              print(_lang[0].label);

                                print("1111111111");
                                selectLanguage(lang:"ar");
                                await localization.setNewLanguage('ar', true);
                                setState(() {
                                  langInInit = "ar" ;
                                });


                          },
                          child: SelectCard(
                            list: _lang,
                            title: "language",
                            localization: langInInit == "ar" ? true:false,

                          ),
                        ),
                        InkWell(
                          onTap: ()async{
                            print(lang[0].label);

                            print("222222222222");
                            selectLanguage(lang:"en");
                            await localization.setNewLanguage('en', true);
                            setState(() {
                              langInInit = "en" ;
                            });


                          },
                          child: SelectCard(
                            list: lang,
                            title: "language",
                        localization: langInInit == "en" ? true:false,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
              child:
              SpecialButton(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                          (Route<dynamic> route) => false);
                },
                text: localization.text("save"),
                textColor: Colors.white,
              ),


            )
          ],
        ),
      ),
    );
  }
}