import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'dart:async';
import 'package:cashpoint/src/UI/Authentication/signUp.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileForRegister extends StatefulWidget {
  @override
  _MobileForRegisterState createState() => _MobileForRegisterState();
}

class _MobileForRegisterState extends State<MobileForRegister> {
  String phone;
//  var _countryId;
  var shownCountryCode;
  var countries=[];
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();


//  getCountries() async {
//      LoadingDialog(_scafold, context).showLoadingDilaog();
//      await ApiProvider(_scafold, context)
//          .getCountries()
//          .then((value) async {
//        if (value.code == 200) {
//          print('correct');
//          Navigator.pop(context);
//
//          setState(() {
//            countries = value.data ;
//          });
//
//        } else {
//          print('error >>> ' + value.error[0].value);
//          Navigator.pop(context);
//
//          LoadingDialog(_scafold, context)
//              .showNotification(value.error[0].value);
//        }
//      });
//
//  }

  registerForMobile() async {
    if (phone == null || phone.length < 10) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("short_phone"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();

      await ApiProvider(_scafold, context)
          .registerForMobile(
        phone: phone,
//        country_id: _countryId
      )
          .then((value) async {
        if (value.code == 200) {
          print('correct');
          Navigator.pop(context);
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => SendingCode(phone:phone)));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SendingCode(phone: phone, typeOfCode: "mobileRegister",
//                        countryId: _countryId,
                      )));
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);

          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }


  SharedPreferences _prefs;
  var logo ;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      logo = _prefs.getString("logo");
    });
//    getCountries();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      _getShared();

    });

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: _scafold,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
//                Image.asset(
//                  "assets/cashpoint/Nbackground.png",
//                  fit: BoxFit.fill,
//                  width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height,
//                ),
                ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: MyColors.darkRed),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:CachedNetworkImage(
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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.text("sign_up"),
                          style: MyColors.styleBold3,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),
                          SpecialTextField(
                            icon: Icon(
                              Icons.phone_android,
                              color: MyColors.orange,
                              size: 19,
                            ),
                            hint: localization.text("phone_number"),
                            iconCircleColor: Colors.grey[200],
                            keyboardType: TextInputType.phone,
                            onChange: (value) {
                              setState(() {
                                phone = value;
                              });
                            },
                          ),
                          SizedBox(height: 15),

//                          InkWell(
//                            onTap: () {
//                              bottomSheet(context, countries, "countries");
//                            },
//                            child: Container(
//                              height: 50,
//                              decoration: BoxDecoration(
//                                border: Border.all(color: Colors.black54),
//                                borderRadius: BorderRadius.all(
//                                  Radius.circular(10),
//                                ),
//                              ),
//                              child: Row(
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.all(5.5),
//                                    child: InkWell(
////                                      onTap: widget.onIconTap,
//                                      child: CircleAvatar(
//                                        radius: 17.5,
//                                        backgroundColor: Colors.grey[200],
//                                        child: Container(
//                                          height: 25,
//                                          width: 25,
//                                          child: Icon(
//                                            Icons.flag,
//                                            size: 22,
//                                            color: MyColors.orange,
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
////                                  Expanded(
////                                    child: Container(
////                                      child: Padding(
////                                        padding: const EdgeInsets.symmetric(
////                                            horizontal: 4),
////                                        child: Row(
////                                          mainAxisAlignment:
////                                              MainAxisAlignment.spaceBetween,
////                                          children: <Widget>[
////                                            Text(
////                                        shownCountryCode ??  localization.text("choose country code"),
////                                              style: TextStyle(
////                                                  fontSize: 16,
////                                                  // fontFamily: "Tajawal",
////                                                  fontWeight: FontWeight.normal,
////                                                  color: Colors.black),
////                                            ),
////                                            Icon(
////                                              Icons.arrow_drop_down,
////                                              size: 27,
////                                              color: Colors.black,
////                                            )
////                                          ],
////                                        ),
////                                      ),
////                                    ),
////                                  )
//                                ],
//                              ),
//                            ),
//                          ),
                          SizedBox(height: 15),
                          SpecialButton(
                            onTap: () {
                              registerForMobile();

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => SendingCode(phone:phone,forgetPassword:false)));
                            },
                            text: localization.text("send"),
                            color: MyColors.orange,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }

  bottomSheet(BuildContext context, List<dynamic> list, String name) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView(children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
//                                      _countryId = list[index].id ;
                                      shownCountryCode = "${list[index].name}  ${list[index].code}" ;
                                    });
                                  },
                                  title: Center(
                                    child:  Text(
                                                "${list[index].name}  ${list[index].code}",
                                                style: MyColors.styleBold1,
                                                textAlign: TextAlign.center,
                                              ),
                                  )),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        });
  }
}
