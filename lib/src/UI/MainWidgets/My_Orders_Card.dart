import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class MyOrderCard extends StatefulWidget {
  final num;
  final name;
  final myOrder;
  final category;
  final date;
  final city;
  final status;
  final img;

  final scaffold;
  final apiToken;
  final id;
  final getData;

  const MyOrderCard({
    Key key,
    this.city,
    this.myOrder,
    this.status,
    this.apiToken,
    this.category,
    this.num,
    this.name,
    this.date,
    this.scaffold,
    this.id,
    this.img,
    this.getData,
  }) : super(key: key);

  @override
  _MyOrderCardState createState() => _MyOrderCardState();
}

class _MyOrderCardState extends State<MyOrderCard> {
  var detailsColor;







  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CachedNetworkImage(
                    imageBuilder: (context, provider) {
                      return Container(
                          height: 95,
                          width: 128,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  image: provider, fit: BoxFit.cover)));
                    },
                    fit: BoxFit.cover,
                    imageUrl: "${widget.img}",
                    placeholder: (context, url) => new Container(
                      height: 100,
                      width: 100,
                      color: Colors.transparent,
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Center(child: CircularProgressIndicator())),
                    ),
                    errorWidget: (context, url, error) => new Container(
//          height: 100,
//          width: 100,
                      color: MyColors.grey,
                    ),
                  ),

                  SizedBox(width:8,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 26,
                          child: Text(
                            "${localization.text("order")} ${widget.category}",
                            style: MyColors.styleNormal2,
                          ),
                        ),
                        Container(
                          height: 23,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${localization.text("_order_number")}",
                                style: MyColors.styleNormal1,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "${widget.num}",
                                style: MyColors.styleNormal1,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 23,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${localization.text("_order state")}",
                                style: MyColors.styleNormal1,
                              ),
                              SizedBox(width: 5,),

                            ],
                          ),
                        ),

                        SizedBox(height: 3,),
                        Text(
                          "${widget.myOrder.restOfOrder.length != 0 ? widget.myOrder.restOfOrder[widget.myOrder.restOfOrder.length - 1].date : widget.myOrder.date}",
                          style: MyColors.styleNormalSmall,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${localization.text("from")}  ${widget.myOrder.restOfOrder.length != 0 ? widget.myOrder.restOfOrder[widget.myOrder.restOfOrder.length - 1].fromOrder.substring(0, 5) :    widget.myOrder.fromOrderShift.substring(0, 5)}",
                              style: MyColors.styleNormalSmall,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "${localization.text("to")}  ${widget.myOrder.restOfOrder.length != 0 ? widget.myOrder.restOfOrder[widget.myOrder.restOfOrder.length - 1].toOrder.substring(0, 5) :    widget.myOrder.toOrderShift.substring(0, 5)}",
                              style: MyColors.styleNormalSmall,
                            ),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            widget.city == null ? Container():   Flexible(
                              child: Text(
                                "${localization.text("service location")} ${widget.city}",
                                style: MyColors.styleNormal0,
                              ),
                            ),



                            Row(
                              children: <Widget>[
                                SizedBox(width: 3,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.blue,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 6),
                                    child: Text(
                                      localization.text("details"),
                                      style: MyColors.styleNormalWhitesmal3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

//          Positioned(top: 5,left: 5,child:
//            InkWell(
//              onTap: () {
//                LoadingDialog(widget.scaffold,context)
//                    .deleteAlert(null,(){deleteMeal();} );
//
//              },
//              child: Icon(
//                Icons.cancel,
//                color: Color(0xffeb3c24),
//                size: 23,
//              ),
//            ),)
          ],
        ),
      ),
    );
  }
}
