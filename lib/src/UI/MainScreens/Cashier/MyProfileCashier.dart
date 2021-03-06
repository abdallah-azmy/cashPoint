import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainScreens/ChangeCashPoint.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyProfileForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/Settings_Row.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileCashier extends StatefulWidget {
  final scaffold;
  MyProfileCashier({
    this.scaffold,
  });
  @override
  _MyProfileCashierState createState() => _MyProfileCashierState();
}

class _MyProfileCashierState extends State<MyProfileCashier> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var barCode =
      "https://www.qr-code-generator.com/wp-content/themes/qr/new_structure/markets/core_market_full/generator/dist/generator/assets/images/websiteQRCode_noFrame.png";

  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  var details;
  var name;
  var loadingToken = true;
  var imgFromCach;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      imgFromCach = _prefs.getString("image");
      name = _prefs.getString("name");
      loadingToken = false;
    });
    apiToken == null ? print("no token") : getDataForClient();

//    print("api_token >>>>> $apiToken");
  }

  getDataForClient() async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .getMyProfileClient(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data[0];
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

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
            ?
    LoginPage()

            : logInType == "????????"
                ? MyProfileForStore()
                : Directionality(
                    textDirection:
                        localization.currentLanguage.toString() == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Scaffold(
                        key: _scafold,
                        resizeToAvoidBottomInset: true,
                        backgroundColor: Color(0xffF5F6F8),
                        body: RefreshIndicator(
                          onRefresh: () {
                            return getDataForClient();
                          },
                          child: SafeArea(
                            child: Stack(
                              children: <Widget>[

                                ListView(
                                  children: <Widget>[
//
                                    Container(
                                      decoration: BoxDecoration(
                                          color: MyColors.darkRed),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 9,
                                                      right: 10,
                                                      left: 10),
                                                  child: Text(
                                                    localization
                                                        .text("profile"),
                                                    style: MyColors
                                                        .styleBold2white,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
//                                                    SizedBox(
//                                                      height: 12,
//                                                    ),
                                                    CachedNetworkImage(
                                                      height: 90,
                                                      width: 90,
                                                      fit: BoxFit.fill,
                                                      imageUrl:
//                                                      details == null
//                                                          ? " "
//                                                          : details.userImage ==
//                                                                  null
//                                                              ? " "
//                                                              : "${details.userImage}",
                                                         "$imgFromCach",
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10000.0),
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10000.0),
                                                              child: Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              new Container(
                                                        height: 80,
                                                        width: 80,
//                                      color: MyColors.grey,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                      placeholderFadeInDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  500),
                                                      errorWidget: (context, url, error) =>  Container(
                                                        height: 80,
                                                        width: 80,
//                                      color: MyColors.grey,
                                                        child: Center(
                                                            child:
                                                            Icon(Icons.error,color: Colors.white,size: 30,)),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
//
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: MyColors.darkRed,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(80),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(80),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),



                                      ],
                                    ),







                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Column(
                                        children: [

                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                Material(
                                                  elevation: 8,
                                                  borderRadius:
                                                  BorderRadius.circular(3),
                                                  child: CachedNetworkImage(
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit.fill,
                                                    imageUrl: details == null
                                                        ? " "
                                                        : details.qrcode == null
                                                        ? " "
                                                        : "${details.qrcode}",
                                                    imageBuilder: (context,
                                                        imageProvider) =>
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                2),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                            child: Container(
                                                              height: 85,
                                                              width: 85,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(3),
                                                                image: DecorationImage(
                                                                    image:
                                                                    imageProvider,
                                                                    fit:
                                                                    BoxFit.cover),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    placeholder: (context, url) =>
                                                    new Container(
                                                      height: 85,
                                                      width: 85,
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),),
//                                      color: MyColors.grey,
                                                      child: Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                    ),
                                                    placeholderFadeInDuration:
                                                    Duration(
                                                        milliseconds: 500),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                    new Container(
                                                      height: 85,
                                                      width: 85,
//                                                    color: MyColors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                localization.text("welcome_user"),
                                                style: MyColors
                                                    .styleBold4white,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                name == null ? "" : "$name" ,
                                                style: MyColors
                                                    .styleBold4white,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            details == null
                                                ? ""
                                                : details.email ==
                                                null
                                                ? ""
                                                : "${details.email}",
                                            style: MyColors
                                                .styleBoldOrangeSmall,
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),



//                                          Text(
//                                            "${localization.text("Membership No")} ${details == null ? " " : details.userMembershipNum == null ? " " : "${details.userMembershipNum}"}",
//                                            style: MyColors.styleNormalSmall,
//                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: 15,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          Column(children: [

                                            Text(
                                              localization.text(
                                                  "Membership N"),
                                              style: MyColors
                                                  .styleNormal15Grey,
                                            ),

                                            Text(
                                              details == null ? " " : details.userMembershipNum == null ? " " : "${details.userMembershipNum}",
                                              style: MyColors
                                                  .styleNormal15Grey,
                                            ),


                                          ],),
                                          Column(children: [
                                            Text(
                                              localization.text(
                                                  "Membership type"),
                                              style: MyColors
                                                  .styleNormal15Grey,
                                            ),

                                            Text(
                                              details == null
                                                  ? " "
                                                  : details.member ==
                                                  null
                                                  ? " "
                                                  : "${details.member.title}",
                                              style: MyColors
                                                  .styleNormal15Grey,
                                            ),
                                          ],)
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    details == null
                                        ? Container()
                                        : details.remain == null
                                            ? Container()
                                            : (details.remain >=
                                                    details.minLimitReplacement)
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: SpecialButton(
                                                      text: localization.text("change cash back"),
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ChangeCashPoint(
                                                                          getData:
                                                                              () {
                                                                            getDataForClient();
                                                                          },
                                                                        )));
                                                      },
                                                    ),
                                                  )
                                                : Container()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
  }
//
//  enterVerificationCode(BuildContext context, var email, String txt) {
//    return showModalBottomSheet<dynamic>(
//        isScrollControlled: true,
//        backgroundColor: Colors.white,
//        context: context,
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//        builder: (BuildContext bc) {
//          return Padding(
//            padding: MediaQuery.of(context).viewInsets,
//            child: Padding(
//              padding: const EdgeInsets.only(top: 20.0),
//              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                ListTile(
//                    onTap: () {},
//                    title: Center(
//                      child: Text(
//                        txt,
//                        textAlign: TextAlign.center,
//                        style: MyColors.styleBold1,
//                      ),
//                    )),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: SpecialTextField(
//                    icon: Icon(
//                      Icons.mail_outline,
//                      color: Colors.black,
//                      size: 19,
//                    ),
//                    hint: "???????? ??????????",
//                    keyboardType: TextInputType.emailAddress,
//                    onChange: (value) {
//                      setState(() {
//                        verificationCode = value;
//                      });
//                    },
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: SpecialButton(
//                    onTap: () {
////                      sendCode();
//                    },
//                    text: "????????",
//                  ),
//                ),
//              ]),
//            ),
//          );
//        });
//  }
}
