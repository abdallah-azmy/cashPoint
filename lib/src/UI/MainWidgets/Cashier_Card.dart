import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainScreens/EditCashier.dart';
import 'package:cashpoint/src/UI/MainScreens/photoGallaryString.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:url_launcher/url_launcher.dart';

class CashierCard extends StatefulWidget {
  final phone;
//  final num;
  final points;
  final description;
  final name;
  final img;
  final price;
  final cashier;
  final rateFunction;

  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const CashierCard(
      {Key key,
      this.apiToken,
      this.rateFunction,
      this.price,
      this.cashier,
      this.description,
      this.img,
      this.name,
      this.scaffold,
      this.onTap,
      this.points,
      this.orderId,
      this.phone,
//      this.num,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _CashierCardState createState() => _CashierCardState();
}

class _CashierCardState extends State<CashierCard> {

  List<ImageOfOrder> images = [];



  callPhone(num) {
    String phoneNumber = "tel:" + num;
    launch(phoneNumber);
  }




  deleteCashier() async {
    Navigator.pop(context);
    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
    await ApiProvider(widget.scaffold, context)
        .deleteCashier(
      apiToken: widget.apiToken,
      cashier_id: widget.id,
    )
        .then((value) async {
      if (value.code == 200) {
//        print('Branch says >>>>> ' + value.data.value);

        Navigator.pop(context);
        LoadingDialog(widget.scaffold,context).alertPopUp(value.data.message);
        widget.getData();
      } else {
//        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
//        Navigator.pop(context);

        LoadingDialog(widget.scaffold,context).alertPopUp(value.error[0].value);
      }
    });
  }



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
                    Text(
                      "${widget.name}",
                      style: MyColors.styleBold0,
                    ),
                    SizedBox(
                      height: 3,
                    ),
//                  Text("${widget.name}",style: MyColors.styleNormal1,),
                    InkWell(
                      onTap: (){
                        callPhone("${widget.phone}");
                      },
                      child: Text(
                        "${widget.phone}",
                        style:  MyColors.styleNormal0blue,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    Text(
                      "${widget.description}",
                      style: MyColors.styleNormalSmal2,
                    ),
                    SizedBox(
                      height: 3,
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
                           InkWell(
                             onTap: (){
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                           EditCashier(cashier: widget.cashier,apiToken: widget.apiToken,id:  widget.id,getData: widget.getData,)));
                               //EditCashierState
                             },
                             child: ClipRRect( borderRadius: BorderRadius.circular(100.0),child: Container(color: Colors.black,child: Padding(
                               padding: const EdgeInsets.all(5.0),
                               child: Icon(Icons.edit,color: Colors.white,size: 16,),
                             ))),
                           ),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap: (){
                                LoadingDialog(widget.scaffold,context)
                                    .deleteAlert(null,(){deleteCashier();} );

                              },
                              child: ClipRRect( borderRadius: BorderRadius.circular(100.0),child: Container(color: Colors.red[900],child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.delete,color: Colors.white,size: 16,),
                              ))),
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
