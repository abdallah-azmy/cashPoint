import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainScreens/MyFatooraWebview.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:cashpoint/src/firebaseNotification/firebaseNotifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyHomeForCashier extends StatefulWidget {
  final scaffold;
  MyHomeForCashier({
    this.scaffold,
  });
  @override
  _MyHomeForCashierState createState() => _MyHomeForCashierState();
}

class _MyHomeForCashierState extends State<MyHomeForCashier> with WidgetsBindingObserver {
  FirebaseNotifications appPushNotifications = FirebaseNotifications();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  var loading = true;
  String restaurantSearch;
  var details;


  var lastLoginCashier;


  var memberDetails;
  var addingPointsProcessDetails;

  var _memberShipNum;
  var _cash;
  var _image;
  var imgFromCach;
  var name;

  var detailsOfGeneralData;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      lastLoginCashier = _prefs.getBool("lastLoginCashier");
      loading = false;
      imgFromCach = _prefs.getString("image");
      name = _prefs.getString("name");
    });
    print("api_token ***** $apiToken");
    getData();
  }

  getData() async {
    print("api_token >>44444444444444888884>>> $apiToken");
    LoadingDialog(_key, context).showLoadingDilaog();
    apiToken == null ? print("no token") : await ApiProvider(_key, context)
        .logOutServiceCashier(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("11111111111111111111111111");
        print("correct logOut");
        _prefs.setBool('lastLoginCashier', true);
//        Navigator.pop(context);

//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) => SplashScreen()),
//            (Route<dynamic> route) => false);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
    await ApiProvider(_key, context)
        .checkPaidCashier(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          details = value.data.value;
        });

        details == 1 ? LoadingDialog(_key, context).showHighNotification(localization.text("payment confirmed")) : print("aaa");



//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error);
        Navigator.pop(context);

        LoadingDialog(_key, context).showHighNotification(value.error);
      }
    });


    await ApiProvider(_key, context)
        .getGeneralData()
        .then((value) async {
      if (value.code == 200) {
        setState(() {
          detailsOfGeneralData = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  readMembershipNum() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .readMemberShipNumCashier(apiToken: apiToken, membership_num: _memberShipNum)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          memberDetails = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error);
        Navigator.pop(context);

        if (value.error == "Sorry something went wrong, please try again") {
          LoadingDialog(_key, context).alertPopUp(localization.text("An error occurred client not found"));
        } else {
          LoadingDialog(_key, context).alertPopUp(value.error);
        }
      }
    });
  }

  readMembershipQR(value) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .readMemberShipQRCashier(apiToken: apiToken, qrcode: value)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          memberDetails = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error);
        Navigator.pop(context);

        if (value.error == "Sorry something went wrong, please try again") {
          LoadingDialog(_key, context).alertPopUp(localization.text("An error occurred client not found"));
        } else {
          LoadingDialog(_key, context).alertPopUp(value.error);
        }
      }
    });
  }

  String barcodeScanRes;

  getLink() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "CANCEL", true, ScanMode.DEFAULT);

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $barcodeScanRes");
    return barcodeScanRes;
  }

  addPoints() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .addPointsCashier(apiToken: apiToken, user_id: memberDetails.id, cash: _cash)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        Navigator.pop(context);

        setState(() {
          addingPointsProcessDetails = value.data;
        });
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  confirmAddingPoints() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .confirmAddingPointsCashier(
            apiToken: apiToken, transaction_id: addingPointsProcessDetails.id)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        Navigator.pop(context);
        setState(() {
          memberDetails = null;
          addingPointsProcessDetails = null;
        });
        LoadingDialog(_key, context)
            .alertPopUp(localization.text("added_successfully"));

        _getShared();
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
//    uploadPic(context);
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        Future.delayed(Duration(milliseconds: 300), () {
          if (this.mounted) {
            _getShared();
          }
//          this._getShared();
        });

        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
//      case AppLifecycleState.suspending:
//        print('appLifeCycleState suspending');
//        break;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("<<<<>>>><<<<<>>>>>>>");
//    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration(milliseconds: 300), () {
      print("------------------XXXXXX--------");
      appPushNotifications.notificationSubject.stream.listen((data) {
        getData();
        print("------------------XXXXXX-------- $data");
        print("------------------XXXXXX-------- ${data.length}");
        if (Platform.isIOS == true) {
          print("ios");
          LoadingDialog(_key, context).showDoubleNotification(data['aps']['alert']['title'],data['aps']['alert']['body']);
        } else {
          LoadingDialog(_key, context).showDoubleNotification( data['notification']['title'],data['notification']['body']);
        }
      }).onError((err) {
        print("------------------- $err");
      });
//      if (this.mounted) {
//      _getShared();
//      }

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getShared();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: _key,
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xffF5F6F8),
          body: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: SafeArea(
              child: ListView(
                children: <Widget>[
//
                  Container(
                    decoration: BoxDecoration(color: MyColors.darkRed),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                             localization.text("hello"),
                              style: MyColors.styleNormalOrange1,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
//                              details == null
//                                  ? " "
//                                  : details.name == null
//                                      ? " "
//                                      : "${details.name}",
                              name == null ? " " : "$name",
                              style: MyColors.styleBold4white,
                            ),
                            SizedBox(
                              height: 18,
                            ),
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
                            height: 70,
                            decoration: BoxDecoration(
                              color: MyColors.darkRed,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: MyColors.darkRed,
                              borderRadius: BorderRadius.only(
//                        bottomLeft:  Radius.circular(80),
                                  ),
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f6f8),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(80),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(170),
                            child: CachedNetworkImage(
                              height: 120,
                              width: 120,
                              fit: BoxFit.fill,
                              imageUrl:
//                              details == null
//                                  ? " "
//                                  : details.logo == null
//                                      ? " "
//                                      : "${details.logo}",
                                  "$imgFromCach",
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10000.0),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
//                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10000.0),
                                    child: new Container(
                                      height: 120,
                                      width: 120,
//                                      color: MyColors.grey,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                ),
                              ),
                              placeholderFadeInDuration:
                                  Duration(milliseconds: 500),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10000.0),
                                    child: new Container(
                                      height: 120,
                                      width: 120,
                                      color: MyColors.grey,
                                      child: Center(
                                          child: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  memberDetails == null
                      ? Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                 localization.text("Scan a code"),
                                  style: TextStyle(height: 1),
                                ),
                                Text(
                                  localization.text("last_sign_in"),
                                  style: TextStyle(height: 1.2),
                                ),
//                                Text(
//                                  details == null
//                                      ? " "
//                                      : details.lastLoginAt == null
//                                          ? " "
//                                          : "${details.lastLoginAt}",
//                                  style: TextStyle(fontWeight: FontWeight.bold),
//                                ),
                              ],
                            ),
                            details == null
                                ? Container()
                                : (details == 0)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Container(
                                          color: Colors.green[900],
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Text(
                                               localization.text("Wait for administration confirmation of payment"),
                                                style:
                                                    MyColors.styleNormalWhite,
                                              ),
//                                              Text(
//                                                "${details.currentCommissions}",
//                                                style:
//                                                    MyColors.styleNormalWhite,
//                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : (details == 3)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            child: Container(
                                              color: Colors.red,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    localization.text("The due commission must be paid"),
                                                    style: MyColors
                                                        .styleNormalWhite,
                                                  ),
//                                                  Text(
//                                                    "${details.currentCommissions}",
//                                                    style: MyColors
//                                                        .styleNormalWhite,
//                                                  ),
//                                                  SizedBox(
//                                                    height: 12,
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets
//                                                            .symmetric(
//                                                        horizontal: 25),
//                                                    child: SpecialButton(
//                                                      onTap: () {
////                                                        chooseFiltrationMethod(
////                                                            context);
//                                                      },
//                                                      text: localization.text("pay"),
//                                                    ),
//                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : (details == 1 ||
                                                details == 4)
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: InkWell(
                                                        onTap: () {
                                                          getLink().then(
                                                              (value) async {
                                                            print(
                                                                "333333333 $value");
                                                            value.toString() ==
                                                                    "-1"
                                                                ? print(
                                                                    "no value")
                                                                : await readMembershipQR(
                                                                    "$value");
                                                          });

                                                          print(
                                                              "$barcodeScanRes");
                                                        },
                                                        child: Material(
                                                          elevation: 8,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18),
                                                                    border: Border.all(
                                                                        color: MyColors
                                                                            .orange)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          9.0),
                                                                  child:
                                                                      Container(
                                                                    height: 110,
                                                                    width: 110,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      image: DecorationImage(
                                                                          image: AssetImage(
                                                                            "assets/cashpoint/qr.png",
                                                                          ),
                                                                          fit: BoxFit.fill),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                child: Icon(Icons
                                                                    .camera_alt),
                                                                bottom: 5,
                                                                left: 9,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "QR",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 13,
                                                  ),
//                                                  details.isPaid == 4
//                                                      ? Container()
//                                                      : Column(
//                                                          children: [
//                                                            Container(
//                                                              color: Colors
//                                                                  .green[900],
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .symmetric(
//                                                                      vertical:
//                                                                          10),
//                                                              width:
//                                                                  MediaQuery.of(
//                                                                          context)
//                                                                      .size
//                                                                      .width,
//                                                              child: Column(
//                                                                children: [
//                                                                  Text(
//                                                                    "???? ?????????? ??????????",
//                                                                    style: MyColors
//                                                                        .styleNormalWhite,
//                                                                  ),
//                                                                  Icon(
//                                                                    Icons
//                                                                        .check_circle,
//                                                                    size: 20,
//                                                                    color: Colors
//                                                                        .white,
//                                                                  ),
//                                                                  SizedBox(
//                                                                    height: 3,
//                                                                  ),
//                                                                ],
//                                                              ),
//                                                            ),
//                                                            SizedBox(
//                                                              height: 10,
//                                                            ),
//                                                          ],
//                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 35,
                                                            left: 35,
                                                            bottom: 10),
                                                    child: SpecialTextField(
                                                      hint:
                                                         localization.text("Enter the customer's phone number or membership"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChange: (value) {
                                                        setState(() {
                                                          _memberShipNum =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 35,
                                                            left: 35,
                                                            bottom: 10),
                                                    child: SpecialButton(
                                                      text: localization
                                                          .text("send"),
                                                      onTap: () {
                                                        if (_memberShipNum ==
                                                            null) {
                                                          LoadingDialog(
                                                                  _key, context)
                                                              .alertPopUp(
                                                                  localization.text(
                                                                      "needed_information"));
                                                        } else {
                                                          readMembershipNum();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : details == 2
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 25),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          color: Colors.red[900],
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 10),
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                               localization.text("The payment request was rejected"),
                                                                style: MyColors
                                                                    .styleNormalWhite,
                                                              ),
//                              Icon(Icons.ch,size: 20,color: Colors.white,),

                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),




//                                                        SizedBox(
//                                                          height: 10,
//                                                        ),

//                                                        Text(
//                                                          "${details.currentCommissions}",
//                                                          style: MyColors
//                                                              .styleNormal1,
//                                                        ),
//                                                        SizedBox(
//                                                          height: 12,
//                                                        ),
//                                                        Padding(
//                                                          padding: const EdgeInsets
//                                                              .symmetric(
//                                                              horizontal: 25),
//                                                          child: SpecialButton(
//                                                            onTap: () {
////                                                              chooseFiltrationMethod(
////                                                                  context);
//                                                            },
//                                                            text: localization.text("Pay"),
//                                                          ),
//                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                            SizedBox(
                              height: 120,
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.darkRed,
                                    borderRadius: BorderRadius.circular(8)),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    CachedNetworkImage(
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.cover,
                                      imageUrl: memberDetails.image,
                                      imageBuilder: (context, imageProvider) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10000.0),
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: imageProvider,
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
                                            child: CircularProgressIndicator()),
                                      ),
                                      placeholderFadeInDuration:
                                          Duration(milliseconds: 500),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000.0),
                                        child: new Container(
                                          height: 80,
                                          width: 80,
                                          color: MyColors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${memberDetails.name}",
                                            style: MyColors.styleBold2white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          addingPointsProcessDetails == null
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          localization.text("phone_number"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${memberDetails.phone}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                         localization.text("Membership N"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${memberDetails.membershipNum}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          localization.text(
                                                              "Membership type"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          memberDetails == null
                                                              ? " "
                                                              : memberDetails
                                                                          .member ==
                                                                      null
                                                                  ? " "
                                                                  : "${memberDetails.member.title}",
                                                          style: MyColors
                                                              .styleBoldOrange,
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Colors.white,
                                                      height: 11,
                                                      thickness: 1,
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          localization.text("order_number"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${addingPointsProcessDetails.orderNumber}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          localization.text("price"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${addingPointsProcessDetails.cash}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                         localization.text("Number of points"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${addingPointsProcessDetails.point}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                         localization.text("The amount deducted from the store"),
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                        Text(
                                                          "${addingPointsProcessDetails.commission}",
                                                          style: MyColors
                                                              .styleBold1white,
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Colors.white,
                                                      height: 11,
                                                      thickness: 1,
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                          addingPointsProcessDetails == null
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5,
                                                              left: 5,
                                                              bottom: 12),
                                                      child: SpecialTextField(
                                                        hint:localization.text("price"),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChange: (value) {
                                                          setState(() {
                                                            _cash = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5,
                                                              left: 5,
                                                              bottom: 12),
                                                      child: SpecialButton(
                                                        onTap: () {
                                                          _cash == null
                                                              ? LoadingDialog(
                                                                      _key,
                                                                      context)
                                                                  .alertPopUp(
                                                                      localization.text("The amount must be entered"))
                                                              : addPoints();
                                                        },
                                                        text: localization.text("add points"),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5,
                                                          left: 5,
                                                          bottom: 12),
                                                  child: SpecialButton(
                                                    onTap: () {
                                                      confirmAddingPoints();
                                                    },
                                                    text: localization.text("Confirm adding points"),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    memberDetails = null;
                                    addingPointsProcessDetails = null;
                                  });
                                },
                                child: Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.cancel,
                                      size: 28,
                                    )),
                              ),
                              left: 11,
                              top: 0,
                            )
                          ],
                        ),
                  SizedBox(height: 170,)
                ],
              ),
            ),
          )),
    );
  }

}
