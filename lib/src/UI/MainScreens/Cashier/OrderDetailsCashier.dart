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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsCashier extends StatefulWidget {
  final scaffold;
  final order;
  OrderDetailsCashier({this.scaffold, this.order});
  @override
  _OrderDetailsCashierState createState() => _OrderDetailsCashierState();
}

class _OrderDetailsCashierState extends State<OrderDetailsCashier> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  callPhone(num) {
    String phoneNumber = "tel:" + num;
    launch(phoneNumber);
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
                        localization.text("details"),
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("order_number"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.order.orderNumber == null
                                ? ""
                                : "${widget.order.orderNumber}",
                            style: MyColors.styleNormal1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("customer_name"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.order.userName == null
                                ? ""
                                : "${widget.order.userName}",
                            style: MyColors.styleNormal1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("store name"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.order.storeName == null
                                ? ""
                                : "${widget.order.storeName}",
                            style: MyColors.styleNormal1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("customer_phone"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: (){
                              callPhone("${widget.order.userPhone}");
                            },
                            child: Text(
                              widget.order.userPhone == null
                                  ? ""
                                  : "${widget.order.userPhone}",
                              style: MyColors.styleNormal0blue,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("store_phone"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: (){
                              callPhone("${widget.order.storePhone}");
                            },
                            child: Text(
                              widget.order.storePhone == null
                                  ? ""
                                  : "${widget.order.storePhone}",
                              style: MyColors.styleNormal0blue,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(

                              children: [
                                Text(
                                  localization.text("price"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.order.cash == null ? "" : "${widget.order.cash}",
                            style: MyColors.styleNormal1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.order.point == null
                              ? Container()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      localization.text("points"),
                                      style: MyColors.styleBold1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.order.point == null
                                    ? ""
                                    : "${widget.order.point}",
                                style: MyColors.styleNormal1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          widget.order.commission == null
                              ? Container()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      localization.text("Commission"),
                                      style: MyColors.styleBold1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.order.commission == null
                                    ? ""
                                    : "${widget.order.commission}",
                                style: MyColors.styleNormal1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  localization.text("date"),
                                  style: MyColors.styleBold1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.order.createdAt == null
                                ? ""
                                : "${widget.order.createdAt}",
                            style: MyColors.styleNormal1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )),
                ],
              )),
        ),
      ),
    );
  }
}

class RateDialog extends StatefulWidget {
  RateDialog({this.reasons, this.function});
  final reasons;
  final dynamic Function(dynamic, dynamic) function;

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  int selectedRateSentence = 0;
  var _rating = 0.0;
  var _sentenceId;

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
                          widget.function(_rating, _sentenceId);
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
