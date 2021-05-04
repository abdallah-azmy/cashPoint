import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class MyPayments extends StatefulWidget {
  final scaffold;
  final openDrawer;
  MyPayments({this.scaffold, this.openDrawer});
  @override
  _MyPaymentsState createState() => _MyPaymentsState();
}

class _MyPaymentsState extends State<MyPayments> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var payments = [];
  var loading ;
  SharedPreferences _prefs;
  var apiToken;
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
        .getMyPayments(apiToken: apiToken,)
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          payments = value.data;
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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "مدفوعاتي",
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
                    SizedBox(height: 15,),
                    loading == null
                        ? Container()
                        :
                    payments.length == 0
                        ? Expanded(
                          child: ListView(
                      children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height*.8,
                            child: Center(
                                child: Text("لا توجد مدفوعات")),
                          ),
                      ],
                    ),
                        )
                        : Expanded(
                          child: ListView.builder(shrinkWrap: true,
                      itemBuilder: (context, i) {
                          return  PaymentCard(

                              img: payments[i].image,

//                              name: orders[i]["name"],
                              num:  payments[i].id,
                              price:  payments[i].total,
                              status:  payments[i].status,
                              time:   payments[i].createdAt,
//                              points:  orders[i]["points"],
                              complete:  true,
                              apiToken: apiToken,
                              scaffold: _key,
                              getData: () {
                                getData();
                              });

                      },
                      itemCount: payments.length,
                    ),
                        ),

                  ],
                )


            ),
          ),
        ),
      ),
    );
  }
}

