import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';
import 'package:cashpoint/src/UI/MainScreens/OrderDetails.dart';
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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class MyOrders extends StatefulWidget {
  final scaffold;
  final openDrawer;
  MyOrders({this.scaffold, this.openDrawer});
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var orders = [];
  var loadingToken = true;
  var loading;
  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      loadingToken = false;
    });
//    print("api_token >>>>> $apiToken");
    apiToken == null ? print("no token") : getData();
    print("$apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getAllOrders(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          orders = value.data;
          loading = "done";
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        setState(() {
          loading = "done";
        });

        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }

  addRate(_rating, _message, id) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .rateOrder(
            apiToken: apiToken,
            rate: _rating.toInt(),
            description: _message,
            transaction_id: id)
        .then((value) async {
      if (value.code == 200) {
//        print('Name  >>>>> ' + value.data[0].rateRestaurantReason);

        Navigator.pop(context);
        LoadingDialog(_key, context)
            .alertPopUpDismissible("تم اضافة التقييم بنجاح");

        Future.delayed(Duration(milliseconds: 750), () {
          Navigator.pop(context);
          getData();
        });
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  refund(id, reason) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .refundRequest(
            apiToken: apiToken,
            transaction_id: id,
            refund_request_reason: reason)
        .then((value) async {
      if (value.code == 200) {
        Navigator.pop(context);
        LoadingDialog(_key, context).alertPopUp(value.data.message);

        Future.delayed(Duration(milliseconds: 750), () {
//          Navigator.pop(context);
          getData();
        });
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        value.error[0].key == "refund_request_reason"
            ? LoadingDialog(_key, context)
                .alertPopUp(localization.text("refund request reason required"))
            : LoadingDialog(_key, context).alertPopUp(value.error[0].value);
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
    return loadingToken == true
        ? Container()
        : apiToken == null
            ? LoginPage()
            : Directionality(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: ListView(
//                            physics:NeverScrollableScrollPhysics()  ,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      logInType == "متجر"
                                          ? localization.text("My sales")
                                          : localization
                                              .text("List of purchases"),
                                      style: MyColors.styleBold2,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              loading == null
                                  ? Container()
                                  : orders.length == 0
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
//                                physics: NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .8,
                                              child: Center(
                                                  child: Text(localization
                                                      .text("no orders"))),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return logInType == "متجر"
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      OrderDetails(
//                                                                      order:
//                                                                          orders[i],
                                                                        id: orders[i]
                                                                            .id,
                                                                      )));
                                                    },
                                                    child: OrderCardForStore(
                                                        refundFunction: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return RefundDialog(
                                                                  id: orders[i]
                                                                      .id,
                                                                  functionRefund:
                                                                      refund,
                                                                );
                                                              });

//                                                        LoadingDialog(widget.scaffold, context)
//                                                            .logOutAlert(
//                                                            localization.text(
//                                                                "refund request"),
//                                                                () {
//                                                                  Navigator.pop(context);
//                                                                  refund(
//                                                                      orders[i].id);
//                                                            });
                                                        },
                                                        num: orders[i]
                                                            .orderNumber,
                                                        price: orders[i].cash,
                                                        time:
                                                            orders[i].createdAt,
                                                        refund: orders[i]
                                                            .refundRequest,
                                                        rate: orders[i].rate,
                                                        complete: orders[i]
                                                            .ratedOrNot,
                                                        pointIsAvailable:orders[i]
                                                            .pointIsAvailable,
                                                        apiToken: apiToken,
                                                        scaffold: _key,
                                                        getData: () {
                                                          getData();
                                                        }),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      OrderDetails(
//                                                                      order:
//                                                                          orders[i],
                                                                        id: orders[i]
                                                                            .id,
                                                                      )));
                                                    },
                                                    child: OrderCard(
//                                              img: orders[i]["img"],
                                                        rateFunction: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return RateDialog(
                                                                  id: orders[i]
                                                                      .id,
                                                                  function:
                                                                      addRate,
                                                                );
                                                              });
                                                        },
                                                        name:
                                                            orders[i].storeName,
                                                        num: orders[i]
                                                            .orderNumber,
                                                        price: orders[i].cash,
                                                        time:
                                                            orders[i].createdAt,
                                                        points: orders[i].point,
                                                        complete: orders[i]
                                                            .ratedOrNot,
                                                        rate: orders[i].rate,
                                                        apiToken: apiToken,
                                                        scaffold: _key,
                                                        getData: () {
                                                          getData();
                                                        }),
                                                  );
                                          },
                                          itemCount: orders.length,
                                        ),
                              SizedBox(
                                height: 90,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              );
  }
}

class RateDialog extends StatefulWidget {
  RateDialog({this.id, this.function});
  final id;
  final dynamic Function(dynamic, dynamic, dynamic) function;

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  var _rating = 0.0;
  var _message;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.transparent,
        content: Container(
//                height: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    localization.text("add rate"),
                    style: MyColors.styleBold2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    itemSize: 28,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),

                  SpecialTextField(
                    hint: localization.text("note"),
                    onChange: (value) {
                      setState(() {
                        _message = value;
                      });
                    },
                    height: 70.0,
                    minLines: 3,
                    maxLines: 3,
                  ),

//                      ListView.builder(
//                        shrinkWrap: true,
//                        physics: NeverScrollableScrollPhysics(),
//                        reverse: true,
//                        itemCount: reasons.length,
//                        itemBuilder: (context, i) {
//                          return Text("${reasons[i].reason}");
//                        },
//                      ),

//                  ListView.builder(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    reverse: true,
//                    itemCount: widget.reasons.length,
//                    itemBuilder: (context, i) {
//                      return Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: [
//                          Container(
//                            height: 25,
//                            width: 25,
//                            child: Radio(
//                              value: i + 1,
//                              groupValue: selectedRateSentence,
//                              activeColor: Color(0xfffead00),
//                              onChanged: (int value) {
//                                setState(() {
//                                  selectedRateSentence = value;
//                                  _sentenceId = widget.reasons[i].id;
//                                });
//
//                                print(
//                                    "##############333 $selectedRateSentence ::::: $_sentenceId");
//                              },
//                            ),
//                          ),
//                          SizedBox(
//                            width: 3,
//                          ),
//                          Text("${widget.reasons[i].reason}"),
//                        ],
//                      );
//                    },
//                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SpecialButton(
                        onTap: () {
                          Navigator.pop(context);
                          widget.function(_rating, _message, widget.id);
                        },
                        width: 85.0,
                        text: localization.text("confirm"),
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                      SpecialButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: localization.text("cancel"),
                        color: Colors.red,
                        width: 85.0,
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class RefundDialog extends StatefulWidget {
  RefundDialog({this.id, this.functionRefund});
  final id;
  final dynamic Function(dynamic, dynamic) functionRefund;

  @override
  _RefundDialogState createState() => _RefundDialogState();
}

class _RefundDialogState extends State<RefundDialog> {
  var _reason;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.transparent,
        content: Container(
//                height: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    localization.text("refund request"),
                    style: MyColors.styleBold2,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 18,
                  ),

                  SpecialTextField(
                    hint: localization.text("refund request reason"),
                    onChange: (value) {
                      setState(() {
                        _reason = value;
                      });
                    },
                    height: 70.0,
                    minLines: 3,
                    maxLines: 3,
                  ),

//                      ListView.builder(
//                        shrinkWrap: true,
//                        physics: NeverScrollableScrollPhysics(),
//                        reverse: true,
//                        itemCount: reasons.length,
//                        itemBuilder: (context, i) {
//                          return Text("${reasons[i].reason}");
//                        },
//                      ),

//                  ListView.builder(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    reverse: true,
//                    itemCount: widget.reasons.length,
//                    itemBuilder: (context, i) {
//                      return Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: [
//                          Container(
//                            height: 25,
//                            width: 25,
//                            child: Radio(
//                              value: i + 1,
//                              groupValue: selectedRateSentence,
//                              activeColor: Color(0xfffead00),
//                              onChanged: (int value) {
//                                setState(() {
//                                  selectedRateSentence = value;
//                                  _sentenceId = widget.reasons[i].id;
//                                });
//
//                                print(
//                                    "##############333 $selectedRateSentence ::::: $_sentenceId");
//                              },
//                            ),
//                          ),
//                          SizedBox(
//                            width: 3,
//                          ),
//                          Text("${widget.reasons[i].reason}"),
//                        ],
//                      );
//                    },
//                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SpecialButton(
                        onTap: () {
                          Navigator.pop(context);
                          widget.functionRefund(widget.id, _reason);
                        },
                        width: 85.0,
                        text: localization.text("confirm"),
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                      SpecialButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: localization.text("cancel"),
                        color: Colors.red,
                        width: 85.0,
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
