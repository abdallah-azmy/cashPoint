import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class OrderCardForStore extends StatefulWidget {
  final time;
  final num;
  final points;
  final refund;
  final rate;
  final complete;
  final pointIsAvailable;
  final isRefunded;
  final name;
  final img;
  final price;
  final refundFunction;

  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const OrderCardForStore(
      {Key key,
      this.apiToken,
      this.pointIsAvailable,
      this.isRefunded,
      this.complete,
      this.rate,
      this.refundFunction,
      this.price,
      this.refund,
      this.img,
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
  _OrderCardForStoreState createState() => _OrderCardForStoreState();
}

class _OrderCardForStoreState extends State<OrderCardForStore> {
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
              SizedBox(
                width: 13,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${localization.text("number")} : ${widget.num}",
                          style: MyColors.styleNormalSmal2,
                        ),
                        widget.pointIsAvailable == 1 ?Text(
                          localization.text("There are no points to refund"),
                          style: MyColors.styleBold0,
                        )  :
                        widget.isRefunded == true
                            ? Container()
                            : widget.refund == 3
                                ? SpecialButton(
                                    onTap: widget.refundFunction,
                                    text: localization.text("Refund request"),
                                    textSize: 14,
                                    height: 35.0,
                                  )
                                : widget.refund == 0
                                    ? Text(
                                        localization.text("The request is pending"),
                                        style: MyColors.styleBold0,
                                      )
                                    : widget.refund == 1
                                        ? Row(
                                            children: [
                                              Text(
                                               localization.text("Retrieved"),
                                                style: MyColors.styleBold0,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            ],
                                          )
                                        : widget.refund == 2
                            ? Row(
                          children: [
                            Text(
                              localization.text("Retrieval denied"),
                              style: MyColors.styleBoldSmall,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 20,
                            )
                          ],
                        )
                            : Container()
                      ],
                    ),
//                  Text("${widget.name}",style: MyColors.styleNormal1,),
                    Text(
                      "${widget.time}",
                      style: MyColors.styleNormalSmal2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                      Text("نقاط ${widget.points}"),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
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
                    Divider()
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
