import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainScreens/photoGallaryString.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class CommissionCard extends StatefulWidget {
  final time;
  final num;
  final points;
  final commission;
  final name;
  final price;
  final status;
  final rateFunction;

  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const CommissionCard(
      {Key key,
      this.apiToken,
      this.rateFunction,
      this.price,
      this.status,
      this.commission,
      this.name,
      this.scaffold,
      this.onTap,
      this.points,
      this.orderId,
      this.time,
      this.num,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _CommissionCardState createState() => _CommissionCardState();
}

class _CommissionCardState extends State<CommissionCard> {

  List<ImageOfOrder> images = [];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
//              color: Colors.white,
              borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "${localization.text("number")} : ${widget.num}",
                            style: MyColors.styleNormalSmal2,
                          ),
                        ),


                        Text(
                          "${widget.time}",
                          style: MyColors.styleNormalSmal2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${localization.text("_customer_name")}  ${widget.name}",
                          style: MyColors.styleNormalSmal2,
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 5,
                    ),


//                    widget.status == 2 ?  Column(
//                      children: [
//                        Text(
//                          localization.text("The bank payment was rejected"),
//                          style: MyColors.styleBold0red,
//                        ),
//                        SizedBox(
//                          height: 1,
//                        ),
//                      ],
//                    ): widget.status == 1 ?
//                    Column(
//                      children: [
//                        Text(
//                          localization.text("Payment confirmed"),
//                          style: MyColors.styleBold0green,
//                        ),
//                        SizedBox(
//                          height: 1,
//                        ),
//                      ],
//                    )
//                        :  widget.status == 0 ?
//                    Column(
//                      children: [
//                        Text(
//                          localization.text("Payment not confirmed"),
//                          style: MyColors.styleBold0,
//                        ),
//                        SizedBox(
//                          height: 1,
//                        ),
//                      ],
//                    ) : Container(),
                    //Payment not confirmed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                      Text("نقاط ${widget.points}"),
                        SizedBox(
                          width: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              localization.text("_price"),
                              style: MyColors.styleBoldOrange,
                            ),

                            SizedBox(
                              width: 3,
                            ),

                            Text(
                              "SR",
                              style: MyColors.styleBoldOrange,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "${widget.price}",
                              style: MyColors.styleBoldOrange,
                            ),
                          ],
                        ),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                      Text("نقاط ${widget.points}"),
                        SizedBox(
                          width: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              localization.text("commission"),
                              style: MyColors.styleBoldOrange,
                            ),

                            SizedBox(
                              width: 3,
                            ),

                            Text(
                              "SR",
                              style: MyColors.styleBoldOrange,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "${widget.commission}",
                              style: MyColors.styleBoldOrange,
                            ),
                          ],
                        ),
                      ],
                    ),


//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
////                      Text("نقاط ${widget.points}"),
//                        SizedBox(
//                          width: 7,
//                        ),
//                        Row(
//                          children: [
//                            Text(
//                              localization.text("_Number of points"),
//                              style: MyColors.styleBoldOrange,
//                            ),
//                            SizedBox(
//                              width: 3,
//                            ),
//                            Text(
//                              "${widget.points}",
//                              style: MyColors.styleBoldOrange,
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),

                    Divider(thickness: 2,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
