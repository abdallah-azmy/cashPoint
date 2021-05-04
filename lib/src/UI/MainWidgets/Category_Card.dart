import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class CategoryCard extends StatefulWidget {
  final distance;
  final rate;
  final name;
  final img;

  final onTap;
  final id;
  final apiToken;
  final categoryId;
  final scaffold;
  final getData;

  const CategoryCard(
      {Key key,
      this.apiToken,
      this.scaffold,
      this.img,
      this.onTap,
      this.name,
      this.categoryId,
      this.distance,
      this.rate,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  deleteNotification() async {
//    Navigator.pop(context);
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .deleteNotification(apiToken: widget.apiToken,notification_id: widget.id)
//        .then((value) async {
//      if (value.code == 200) {
//
//
//        Navigator.pop(context);
//        LoadingDialog(widget.scaffold,context)
//            .showNotification(localization.text("notification_deleted"));
//
//        widget.getData();
//
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        Navigator.pop(context);
//
//        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: CustomProductImage(
                        image: "${widget.img}",
                      ),
                    ),
//                    CachedNetworkImage(
//                      imageBuilder: (context, provider) {
//                        return Container(
//                            height: 80,
//                            width: 80,
//                            decoration: BoxDecoration(
//                                color: Colors.transparent,
//                                borderRadius: BorderRadius.circular(10),
//                                image: DecorationImage(
//                                    image: provider, fit: BoxFit.fill)));
//                      },
//                      fit: BoxFit.fill,
//                      imageUrl: "${widget.img}",
//                      placeholder: (context, url) => new Container(
//                        height: 80,
//                        width: 80,
//                        color: Colors.transparent,
//                        child: Container(
//                            height: 80,
//                            width: 80,
//                            child: Center(child: CircularProgressIndicator())),
//                      ),
//                      errorWidget: (context, url, error) => new Container(
//                        height: 80,
//                        width: 80,
//                        color: MyColors.grey,
//                      ),
//                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "${widget.name}",
                                  style: MyColors.styleBold2,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: MyColors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  child:
//                      Row(
//                        children: [
//                          Text(
//                            "Km",
//                            style: MyColors.styleBold0white,
//                          ),
//                          SizedBox(width: 3,),
//                          Text(
//                            "${widget.distance}",
//                            style: MyColors.styleBold0white,
//                          ),
//
//                        ],
//                      ),

                                      Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${widget.rate.length > 3 ? widget.rate.substring(0, 3) : widget.rate}",
                                        style: MyColors.styleBold0white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),

//                          Row(
//                            children: [
//                              Icon(Icons.star,color: MyColors.orange,size: 18,),
//                              SizedBox(width: 5,),
//                              Text(
//                                "${widget.rate.length > 3 ? widget.rate.substring(0, 3) : widget.rate}" ,
//                                style: MyColors.styleNormalSmal2,
//                              ),
//                            ],
//                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

//              Row(
//                children: [
//                  Container(
//                    decoration: BoxDecoration(color: MyColors.orange,borderRadius: BorderRadius.circular(30)),
//                    child: Padding(
//                      padding: const EdgeInsets.symmetric(horizontal:6,vertical: 5 ),
//                      child:
////                      Row(
////                        children: [
////                          Text(
////                            "Km",
////                            style: MyColors.styleBold0white,
////                          ),
////                          SizedBox(width: 3,),
////                          Text(
////                            "${widget.distance}",
////                            style: MyColors.styleBold0white,
////                          ),
////
////                        ],
////                      ),
//
//                      Row(
//                        children: [
//                          Icon(Icons.star,color: Colors.white,size: 18,),
//                          SizedBox(width: 5,),
//                          Text(
//                            "${widget.rate.length > 3 ? widget.rate.substring(0, 3) : widget.rate}" ,
//                            style: MyColors.styleBold0white,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  SizedBox(width: 5,),
//                ],
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
