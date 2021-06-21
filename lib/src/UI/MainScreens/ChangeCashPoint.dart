import 'package:cashpoint/src/Models/banks.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/My_Orders_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card_ForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangeCashPoint extends StatefulWidget {
  final getData;
  final order;
  ChangeCashPoint({this.getData, this.order});
  @override
  _ChangeCashPointState createState() => _ChangeCashPointState();
}

class _ChangeCashPointState extends State<ChangeCashPoint> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  var apiToken;
  var banks;
  var shownBank;

  var _bankId;
  String _bank_account = "";

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });
    getBanks();
//    print("api_token >>>>> $apiToken");
  }

  getBanks() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context).getBanks().then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          banks = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }


  replacePoints() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    if(_bank_account.length < 12){
      Navigator.pop(context);
      LoadingDialog(_key, context).showNotification(localization.text("_Bank account_length"));
    }else{
      await ApiProvider(_key, context).replacePoints(apiToken: apiToken,type: 0,bank_account: _bank_account,bank_id: _bankId).then((value) async {
        if (value.code == 200) {
          print("correct connection");
          Navigator.pop(context);
          LoadingDialog(_key, context).showNotification(value.data.value);
          Future.delayed(Duration(seconds: 1,milliseconds: 500),(){
            Navigator.pop(context);
          });
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);

          LoadingDialog(_key, context).showNotification(value.error[0].value);
        }
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getShared();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.getData();
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
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                       localization.text("change cashpoint"),
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
                  Expanded(
                      child: ListView(
                    children: [
                      SizedBox(height: 25,),
                      InkWell(
                        onTap: () {
                          bottomSheet(context, banks, "banks");
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
//                                      onTap: widget.onIconTap,
                                  child: CircleAvatar(
                                    radius: 17.5,
                                    backgroundColor: Colors.grey[200],
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      child: Icon(
                                        Icons.flag,
                                        size: 22,
                                        color: MyColors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          shownBank ?? localization.text("change the bank"),
                                          style: TextStyle(
                                              fontSize: 16,
                                              // fontFamily: "Tajawal",
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 27,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      SpecialTextField(
                        hint: localization.text("_Bank account"),
                        height: 40.0,keyboardType: TextInputType.text ,


                        onChange: (value) {
                          setState(() {
                            _bank_account = value;
                          });
                        },
                      ),

                      SizedBox(height: 25,),

                      SpecialButton(text: localization.text("change"),
                      onTap: (){

                        replacePoints();
                      },)
                    ],
                  )),
                ],
              )),
        ),
      ),
    );
  }

  bottomSheet(BuildContext context, List<DatumBanks> list, String name) {
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
                                      _bankId = list[index].id;
                                      shownBank = "${list[index].name}";
                                    });
                                  },
                                  title: Center(
                                    child: Text(
                                      "${list[index].name}",
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
