import 'dart:io';

import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainScreens/MyFatooraWebview.dart';
import 'package:cashpoint/src/UI/MainWidgets/Commission_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/My_Orders_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card_ForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/Payment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class MyCommissions extends StatefulWidget {
  final scaffold;
  final openDrawer;
  MyCommissions({this.scaffold, this.openDrawer});
  @override
  _MyCommissionsState createState() => _MyCommissionsState();
}

class _MyCommissionsState extends State<MyCommissions> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var commissions = [];
  var loading;
  SharedPreferences _prefs;
  var apiToken;
  var details;
  var detailsOfGeneralData;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });
    getData();
//    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getMyProfileStore(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data[0];
        });
        print(">>>>>>>>>>> ${value.data[0].isPaid}");

        details.isPaid == 1
            ? LoadingDialog(_key, context)
                .showNotification(localization.text("payment confirmed"))
            : print("aaa");

//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });

    await ApiProvider(_key, context)
        .getGeneralData()
        .then((value) async {
      if (value.code == 200) {
        setState(() {
          detailsOfGeneralData = value.data;
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        LoadingDialog(_key, context).showNotification(value.error[0].value);
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });

    await ApiProvider(_key, context)
        .showMyCommission(
      apiToken: apiToken,
    )
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          commissions = value.data;
          loading = "done";
        });
        Navigator.pop(context);
      } else {
//        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          loading = "done";
        });

        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }

  var _image;
  bool onlinePaymentURL = false;

  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
//    uploadPic(context);
  }

  payOffCommission(type, fatoora) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .payOffCommission1(
            apiToken: apiToken,
            image: _image,
            payment_type: type,
            my_fatoora: fatoora)
        .then((value) async {
      if (value.code == 200) {
        Navigator.pop(context);
        value.data.paymentUrl != null
            ? LoadingDialog(_key, context).alertPopUp(
                localization.text("Please complete the payment process"))
            : LoadingDialog(_key, context).alertPopUp(
                localization.text("operation accomplished successfully"));

        if (value.data.paymentUrl != null) {
          setState(() {
            onlinePaymentURL = true;
          });
        }

        Future.delayed(Duration(milliseconds: 750), () {
          Navigator.pop(context);
          getData().then((anotherValue) {
            if (value.data.paymentUrl != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OnlinePaymentScreen(
                          url: value.data.paymentUrl,
                          getData: () {
                            _getShared();
                          },
                        )),
              );
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  onlinePaymentURL = false;
                });
              });
            }
          });
        });
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        if (value.error[0].value == "my fatoora لاغٍ") {
          LoadingDialog(_key, context)
              .alertPopUp(localization.text("please try again later"));
        } else {
          LoadingDialog(_key, context).alertPopUp(value.error[0].value);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this._getShared();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xfff5f6f8),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          localization.text("my commissions"),
                          style: MyColors.styleBold2,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    loading == null
                        ? Container()
                        : commissions.length == 0
                            ? Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .8,
                                      child: Center(
                                          child: Text(localization
                                              .text("There are no commissions"))),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return CommissionCard(

//                              img: commissions[i].image,

                                        name: commissions[i].userName,
                                        num: commissions[i].orderNumber,
                                        points: commissions[i].point,
                                        price: commissions[i].cash,
                                        commission: commissions[i].commission,
                                        status: commissions[i].status,
                                        time: commissions[i].createdAt,
                                        apiToken: apiToken,
                                        scaffold: _key,
                                        getData: () {
                                          getData();
                                        });
                                  },
                                  itemCount: commissions.length,
                                ),
                              ),



                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                                localization.text("Total cashpoint commissions"),
                                style: MyColors.styleNormal1,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "SR",
                                style: MyColors.styleBoldOrange,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text( details == null
                                  ? " "
                                  : details.totalCommissions == null
                                  ? " "
                                  : "${details.totalCommissions}",),
                            ],
                          ),
                        ],
                      ),
                    ),

                    commissions.length == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SpecialButton(
                              text: localization.text("Pay"),
                              onTap: () {
                                chooseFiltrationMethod(context);
                              },
                            ),
                          ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  chooseMyFatoora(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      payOffCommission(1, 0);
                    },
                    text: localization.text("pay_by_my_fatoora"),
                  ),
                ),
                details.onlinePayment == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpecialButton(
                          onTap: () {
                            Navigator.pop(context);
                            payOffCommission(1, 1);
                            //مدي واحد
                          },
                          text: localization.text("Pay by Mada"),
                        ),
                      ),
                Platform.isIOS != true
                    ? Container()
                    : details.onlinePayment == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SpecialButton(
                              onTap: () {
                                Navigator.pop(context);
                                payOffCommission(1, 3);
                                //مدي واحد
                              },
                              text: localization.text("pay_by_my_apple"),
                            ),
                          ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          );
        });
  }

  chooseFiltrationMethod(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                details.onlinePayment == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpecialButton(
                          onTap: () {
                            Navigator.pop(context);
                            chooseMyFatoora(context);
//                      payOffCommission(1, 1);
                            //مدي واحد
                          },
                          text: localization.text("pay by myfatoora"),
                        ),
                      ),
                details.onlinePayment == 0 ? Container() : Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      uploadPaymentPhoto(context);
                    },
                    text: localization.text("Bank transfer"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        });
  }

  uploadPaymentPhoto(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                detailsOfGeneralData == null
                    ? Container()
                    : Column(
                        children: [
                          detailsOfGeneralData.bankName == null
                              ? Container()
                              : Text("${detailsOfGeneralData.bankName}"),
                          SizedBox(
                            height: 3,
                          ),
                          detailsOfGeneralData.bankName == null
                              ? Container()
                              : Text("SA${detailsOfGeneralData.bankAccount}"),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      getImage().then((value) async {
                        _image == null
                            ? print("choose the image")
                            : LoadingDialog(widget.scaffold, context).payByBank(
                                localization.text("Attach the link image"), () {
                                Navigator.pop(context);
                                payOffCommission(0, null);
                              });
                      });
                    },
                    text: localization.text("Attach the conversion image"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          );
        });
  }
}
