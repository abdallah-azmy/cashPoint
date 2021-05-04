//import 'package:easy_menu/src/LoadingDialog.dart';
//import 'package:easy_menu/src/MyColors.dart';
//import 'package:easy_menu/src/Network/api_provider.dart';
//import 'package:easy_menu/src/firebaseNotification/appLocalization.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
//import 'package:flutter/rendering.dart';
//
//class MyMealsCard extends StatefulWidget {
//  final title;
//  final description;
//  final price;
//  final calories;
//  final category;
//  final img;
//  final scaffold;
//  final apiToken;
//  final id;
//  final getData;
//  final int isActive;
//
//  const MyMealsCard(
//      {Key key,
//      this.calories,
//      this.category,
//      this.img,
//      this.apiToken,
//      this.title,
//      this.description,
//      this.price,
//      this.scaffold,
//      this.id,
//      this.getData,
//      this.isActive,
//      })
//      : super(key: key);
//
//  @override
//  _MyMealsCardState createState() => _MyMealsCardState();
//}
//
//class _MyMealsCardState extends State<MyMealsCard> {
//
//
//  deleteMeal() async {
//    Navigator.pop(context);
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .deleteMeal(
//      apiToken: widget.apiToken,
//      id: widget.id,
//    )
//        .then((value) async {
//      if (value.code == 200) {
//        print('Branch says >>>>> ' + value.data.value);
//
//        Navigator.pop(context);
//        LoadingDialog(widget.scaffold,context).showNotification(value.data.value);
//
//        widget.getData();
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        Navigator.pop(context);
//
//        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
//      }
//    });
//  }
//
//
//  changeMealStatus(active) async {
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .mealIsActive(
//      apiToken: widget.apiToken,
//      id: widget.id,
//      is_active: active
//    )
//        .then((value) async {
//      if (value.code == 200) {
//        print('Branch says >>>>> ' + value.data.notification);
//
//        Navigator.pop(context);
//        if (active == 1){
//          LoadingDialog(widget.scaffold,context).showNotification(localization.text("The meal now is active"));
//        }else if (active ==0){
//          LoadingDialog(widget.scaffold,context).showNotification(localization.text("The meal now is inactive"));
//        }
//
//
//        widget.getData();
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//
//        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Directionality(
//      textDirection: localization.currentLanguage.toString() == "en"
//          ? TextDirection.ltr
//          : TextDirection.rtl,
//      child: Padding(
//        padding: const EdgeInsets.symmetric(vertical: 7),
//        child: Stack(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//              decoration: BoxDecoration(
//                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.start,
//
//                children: <Widget>[
//                  Expanded(
//                    child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//
//                            Container(
//                              height: 30,
//                              width: 35,
//                              child:   Checkbox(
//                                value: widget.isActive == 1 ? true : false,
//                                onChanged: (value) {
//                                  setState(() {
//                                    if (value == true) {
////                                      _checkedTerms = value;
//                                      changeMealStatus(1);
//
//                                    } else {
////                                      _checkedTerms = value;
//                                      changeMealStatus(0);
//                                    }
//                                  });
//                                },
//                                activeColor: Colors.white,
//                                checkColor: Colors.amber,
//                              ),
//                            ),
//                            Flexible(
//                              child: Text(
//                                "${widget.title}",
//                                style: MyColors.styleBold2,
//                              ),
//                            ),
//                          ],
//                        ),
//                        SizedBox(height: 5,),
//                        Row(
//                          children: <Widget>[
//                            Flexible(
//                              child: Text(
//                                widget.category != null ? "{ ${widget.category} }" : " ",
//                                style: MyColors.styleNormalSmal2,
//                              ),
//                            ),
//                          ],
//                        ),
//                        SizedBox(height: 5,),
//                        Row(
//                          children: <Widget>[
//                            Flexible(
//                              child: Text(
//                                widget.description != null ? "${widget.description}" : " ",
//                                style: MyColors.styleNormalSmal2,
//                              ),
//                            ),
//                          ],
//                        ),
//
//
//                      ],
//                    ),
//                  ),
//
//                  SizedBox(width: 5,),
//                  Container(
//                    width: MediaQuery.of(context).size.width*.25,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.end,
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      children: <Widget>[
//                      SizedBox(height: 25,),
//                        RichText(
//                          text: TextSpan(children: <
//                              TextSpan>[
//                            TextSpan(
//                              text: '${widget.price}',
//                              style: TextStyle(
//                                  color: Color(0xffef803b),
//                                  fontSize: 16,
//                                  fontFamily: "Tajawal",
//                                  fontWeight: FontWeight.bold
//                              ),
//                            ),
//                            TextSpan(
//                              text: " ",
//                              style: MyColors.styleBoldSmall,
//                            ),
//
//                            TextSpan(
//                              text: localization.text("SR"),
//                              style: MyColors.styleNormal0,
//                            ),
//
//                          ]),
//                        ),
//                        SizedBox(height: 5,),
//                        widget.calories != null ?  Container(
//                            decoration: BoxDecoration(color: Color(0xfffead00),
//                                borderRadius: BorderRadius.circular(5)
//                            ),
//
//                            child: Padding(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 10, vertical: 4),
//                              child: localization.currentLanguage.toString() == "en" ? Text(
//                                "calories ${widget.calories}",
//                                style: MyColors.styleBoldSmallWhite,
//                              ):
//                              Center(
//                                child: Text(
//                                  "${widget.calories} سعر حراري",
//                                  style: MyColors.styleBoldSmallWhite2,
//                                  textAlign: TextAlign.center,
//                                ),
//                              ),
//                            )):Container(),
//
//
//                      ],
//                    ),
//                  ),
//
//
//
//
//                ],
//              ),
//            ),
//
//            localization.currentLanguage.toString() == "en"?
//            Positioned(top: 5,right: 5,child:
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
//            ),): Positioned(top: 5,left: 5,child:
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
//          ],
//        ),
//      ),
//    );
//  }
//}
