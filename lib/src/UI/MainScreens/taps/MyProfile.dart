import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainScreens/ChangeCashPoint.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyProfileForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:cashpoint/src/UI/MainWidgets/Settings_Row.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  final scaffold;
  MyProfile({
    this.scaffold,
  });
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();

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
   var pointsToChange = 0;
  var remainWithoutChange ;
  getDataForClient() async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(scaffold, context)
        .getMyProfileClient(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data[0];

          if(details.remain != null ){
            pointsToChange = (details.remain / details.minLimitReplacement).floor();
            remainWithoutChange =  details.minLimitReplacement * pointsToChange;
          }


        });

//        if (details.remain >= details.minLimitReplacement) {
//          pointsToChange = (details.remain / details.minLimitReplacement).floor();

          print("###########${remainWithoutChange}");

//          $valueTaken =  $min_limit_replacement * $times;
//
//          $cashValue =  $valueTaken;
//          $totalPoint->pull =     $valueTaken;
//      $totalPoint->remain =    $point - $valueTaken;
//
//      $totalPoint->save();
//      }



        details.status == 2 ?
        LoadingDialog(scaffold, context).showHighNotification(localization.text("Request to transfer points to active cash"))
            :
        details.status == 3 ?
        LoadingDialog(scaffold, context).showHighNotification(localization.text("Confirm transfer request"))
        :
        details.status == 4 ?
        LoadingDialog(scaffold, context).showHighNotification(localization.text("Transfer request denied"))
            : details.status == 1 ?
        LoadingDialog(scaffold, context).showHighNotification(localization.text("There is no current transfer request")) :
        print("no requist");
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

//        LoadingDialog(scaffold, context).showNotification(value.error[0].value);
        LoadingDialog(scaffold, context).alertPopUp(value.error[0].value);
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
            : logInType == "متجر"
                ? MyProfileForStore()
                : Directionality(
                    textDirection:
                        localization.currentLanguage.toString() == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Scaffold(
                        key: scaffold,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                      errorWidget: (context,
                                                              url, error) =>
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
                                                    ),

//                                                    Row(
//                                                      children: [
//                                                        Text(
//                                                          localization.text("welcome_user"),
//                                                          style: MyColors
//                                                              .styleBold4white,
//                                                        ),
//                                                        SizedBox(
//                                                          width: 5,
//                                                        ),
//                                                        Text(
////                                                          details == null
////                                                              ? " "
////                                                              : details.userName ==
////                                                                      null
////                                                                  ? " "
////                                                                  : "${details.userName}",
//                                                          name == null ? "" : "$name" ,
//                                                          style: MyColors
//                                                              .styleBold4white,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Text(
//                                                      details == null
//                                                          ? ""
//                                                          : details.email ==
//                                                                  null
//                                                              ? ""
//                                                              : "${details.email}",
//                                                      style: MyColors
//                                                          .styleBoldOrangeSmall,
//                                                    ),
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
                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          localization.text("points"),
                                          style: MyColors.styleNormal,
                                        ),
                                        Text(
                                          details == null
                                              ? " "
                                              : details.remain == null
                                                  ? "0"
                                                  : "${details.remain}",
                                          //((num + 99) / 100 ) * 100
                                          //
                                          style: MyColors.styleBigBold,
                                        ),

                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10,
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
                                                  child:

                                                  Container( height: 150,
                                                      width: 150,child: CustomProductImage(
                                                        image: details == null
                                                            ? " "
                                                            : details.qrcode == null
                                                            ? " "
                                                            : details.qrcode,
                                                      ))
//                                                  CachedNetworkImage(
//                                                    height: 150,
//                                                    width: 150,
//                                                    fit: BoxFit.fill,
//                                                    imageUrl: details == null
//                                                        ? " "
//                                                        : details.qrcode == null
//                                                            ? " "
//                                                            : details.qrcode,
//                                                    imageBuilder: (context,
//                                                            imageProvider) =>
//                                                        Container(
//                                                      decoration: BoxDecoration(
//                                                        color: Colors.white,
//                                                        borderRadius:
//                                                            BorderRadius
//                                                                .circular(2),
//                                                      ),
//                                                      child: Padding(
//                                                        padding:
//                                                            const EdgeInsets
//                                                                .all(15.0),
//                                                        child: Container(
//                                                          height: 150,
//                                                          width: 150,
//                                                          decoration:
//                                                              BoxDecoration(
//                                                            borderRadius:
//                                                                BorderRadius
//                                                                    .circular(
//                                                                        3),
//                                                            image: DecorationImage(
//                                                                image:
//                                                                    imageProvider,
//                                                                fit: BoxFit
//                                                                    .cover),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                    placeholder:
//                                                        (context, url) =>
//                                                            new Container(
//                                                      height: 85,
//                                                      width: 85,
//                                                      decoration: BoxDecoration(
//                                                        borderRadius:
//                                                            BorderRadius
//                                                                .circular(8),
//                                                      ),
////                                      color: MyColors.grey,
//                                                      child: Center(
//                                                          child:
//                                                              CircularProgressIndicator()),
//                                                    ),
//                                                    placeholderFadeInDuration:
//                                                        Duration(
//                                                            milliseconds: 500),
//                                                    errorWidget:
//                                                        (context, url, error) =>
//                                                            new Container(
//                                                      height: 85,
//                                                      width: 85,
////                                                    color: MyColors.grey,
//                                                    ),
//                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                localization
                                                    .text("welcome_user"),
                                                style: MyColors.styleBold3,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
//                                                          details == null
//                                                              ? " "
//                                                              : details.userName ==
//                                                                      null
//                                                                  ? " "
//                                                                  : "${details.userName}",
                                                name == null ? "" : "$name",
                                                style: MyColors.styleBold3,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            details == null
                                                ? ""
                                                : details.email == null
                                                    ? ""
                                                    : "${details.email}",
                                            style:
                                                MyColors.styleBoldOrangeSmall,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

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
                                          Column(
                                            children: [
                                              Text(
                                                localization
                                                    .text("Membership N"),
                                                style:
                                                    MyColors.styleNormal15Grey,
                                              ),
                                              Text(
                                                details == null
                                                    ? " "
                                                    : details.userMembershipNum ==
                                                            null
                                                        ? " "
                                                        : "${details.userMembershipNum}",
                                                style:
                                                    MyColors.styleNormal15Grey,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                localization
                                                    .text("Membership type"),
                                                style:
                                                    MyColors.styleNormal15Grey,
                                              ),
                                              Text(
                                                details == null
                                                    ? " "
                                                    : details.member == null
                                                        ? " "
                                                        : "${details.member.title}",
                                                style:
                                                TextStyle(
                                                  color: details == null
                                                      ? Colors.black
                                                      : details.member == null
                                                      ? Colors.black
                                                      :details.member.color == null ? Colors.black : Color(int.parse('0xff${details.member.color.substring(1)}')),
                                                  fontSize: 16,
                                                  // fontFamily: "Tajawal",
//      fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),



                                    details == null ? Container() :    details.main == null  ? Container() :  Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                        Text(localization.text("Total points since registration"),style: MyColors.styleBold0,),
                                        SizedBox(width: 5,),
                                        Text("${details.main}",style: MyColors.styleBold0,),
                                      ],
                                      ),
                                    ),

                                    details == null
                                        ? Container()
                                        : details.allPointClientHave == 1
                                            ? Container(decoration: BoxDecoration(color: Colors.red),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 3),
                                                      child: Text(
                                                         localization.text("There is an active request that has not yet been confirmed"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : details.remain == null
                                                ? Container()
                                                : (details.remain >=
                                                        details
                                                            .minLimitReplacement)
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: SpecialButton(
                                                          text: localization.text(
                                                              "change cash back"),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ChangeCashPoint(
                                                                              getData: () {
                                                                                getDataForClient();
                                                                              },
                                                                              remainWithoutChange: remainWithoutChange,
                                                                            )));
                                                          },
                                                        ),
                                                      )
                                                    : Container(),


                                    details == null
                                        ? Container()
                                        : details.pull == 0 ? Container() :
                                    details.status == 3 ||  details.status == null ? Container() :
                                        Column(
                                          children: [
                                            SizedBox(height: 5,),
                                            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Flexible(child: Text(localization.text("Waiting for management confirmation to convert points to cash"),
                                                style: MyColors.styleBold0,
                                                textAlign: TextAlign.center,
                                              ))
                                            ],),
                                            details.pull == null ? Container() :  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Flexible(child: Text("${details.pull} ${localization.text("point")}",
                                                style: MyColors.styleBold0,
                                                textAlign: TextAlign.center,
                                              ))
                                            ],),
                                            details.bank == null  ? Container() :  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Text(localization.text("bank name"),style: MyColors.styleBold0,),
                                              SizedBox(width: 5,),
                                              Text("${details.bank[0].name}",style: MyColors.styleBold0,),
                                            ],),


                                            details.bankAccount == null  ? Container() :  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Text(localization.text("Bank account"),style: MyColors.styleBold0,),
                                              SizedBox(width: 5,),
                                              Text("${details.bankAccount}",style: MyColors.styleBold0,),
                                            ],),


                                            ],),



                                    SizedBox(height: 150,)
                                          ],
                                        ),


                              ],
                            ),
                          ),
                        )),
                  );
  }
}
