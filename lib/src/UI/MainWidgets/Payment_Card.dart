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

class PaymentCard extends StatefulWidget {
  final time;
  final num;
  final points;
  final complete;
  final name;
  final img;
  final price;
  final status;
  final rateFunction;

  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const PaymentCard(
      {Key key,
      this.apiToken,
      this.rateFunction,
      this.price,
      this.status,
      this.complete,
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
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {

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
              InkWell(
                onTap: (){
                  images.clear();
                  images.add(ImageOfOrder(image: widget.img));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoGallaryString(
                            images: images,
                          )));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 90,
                    width: 90,
                    fit: BoxFit.fill,
                    imageUrl: widget.img == null ? " " : "${widget.img}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => new Container(
                      height: 85,
                      width: 85,
//                                      color: MyColors.grey,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    placeholderFadeInDuration: Duration(milliseconds: 500),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Container(
                          height: 85,
                          width: 85,

                          decoration: BoxDecoration(
                            color: MyColors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 13,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${localization.text("number")} : ${widget.num}",
                          style: MyColors.styleNormalSmal2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
//                  Text("${widget.name}",style: MyColors.styleNormal1,),
                    Text(
                      "${widget.time}",
                      style: MyColors.styleNormalSmal2,
                    ),
                    SizedBox(
                      height: 11,
                    ),


                    widget.status == 2 ?  Column(
                      children: [
                        Text(
                          localization.text("The bank payment was rejected"),
                          style: MyColors.styleBold0red,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ): widget.status == 1 ?
                    Column(
                      children: [
                        Text(
                          localization.text("Payment confirmed"),
                          style: MyColors.styleBold0green,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    )
                        :  widget.status == 0 ?
                    Column(
                      children: [
                        Text(
                          localization.text("Payment not confirmed"),
                          style: MyColors.styleBold0,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ) : Container(),
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
