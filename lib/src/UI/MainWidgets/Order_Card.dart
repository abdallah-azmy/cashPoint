import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderCard extends StatefulWidget {
  final time;
  final num;
  final points;
  final complete;
  final rate;
  final name;
  final img;
  final price;
  final rateFunction;

  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const OrderCard(
      {Key key,
        this.apiToken,
        this.rateFunction,
        this.price,
        this.complete,
        this.img,
        this.rate,
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
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {


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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${localization.text("_number")}${widget.num}",style: MyColors.styleNormalSmal2,),

                     widget.complete == 0 ? SpecialButton(onTap: widget.rateFunction,text: localization.text("rate"),textSize: 15,height: 35.0,) : Container()
                    ],
                  ),
                  Text("${widget.name}",style: MyColors.styleBold3,),
                  Text("${widget.time}",style: MyColors.styleNormalSmal2,),

                  widget.rate == null ? Container() :
                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    Directionality(
                      textDirection: localization.currentLanguage.toString() == "en"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: double.parse('${widget.rate.rate}'),
                          size: 15.0,
                          isReadOnly: true,
                          color: Colors.amber,
                          borderColor: Colors.yellow,
                          spacing: 1.0),
                    )
                  ],),
                  widget.rate == null ? Container() :
                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    Text("${widget.rate.description}",style: MyColors.styleNormalSmal2,),
                  ],),
                  Divider()
                ],),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
