//import 'package:cashpoint/src/LoadingDialog.dart';
//import 'package:cashpoint/src/MyColors.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
//
//class AppointmentCard extends StatefulWidget {
//  final time;
//  final title;
//  final date;
//  final num;
//  final onTap;
//  final id;
//  final apiToken;
//  final scaffold;
//  final getData;
//
//  const AppointmentCard(
//      {Key key,
//      this.apiToken,
//      this.scaffold,
//      this.onTap,
//      this.num,
//      this.date,
//      this.time,
//      this.title,
//        this.getData,
//      this.id})
//      : super(key: key);
//
//  @override
//  _AppointmentCardState createState() => _AppointmentCardState();
//}
//
//class _AppointmentCardState extends State<AppointmentCard> {
////  deleteNotification() async {
////    Navigator.pop(context);
////    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
////    await ApiProvider(widget.scaffold, context)
////        .deleteNotification(apiToken: widget.apiToken,id: widget.id)
////        .then((value) async {
////      if (value.code == 200) {
////        print('Branches number >>>>> ' + value.data.data[0].notification);
////
////
////        Navigator.pop(context);
////        LoadingDialog(widget.scaffold,context)
////            .showNotification(value.data.data[0].notification);
////
////        widget.getData();
////
////
////      } else {
////        print('error >>> ' + value.error[0].value);
////        Navigator.pop(context);
////        Navigator.pop(context);
////
////        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
////      }
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Directionality(
//      textDirection:  TextDirection.rtl,
//      child: Padding(
//        padding: const EdgeInsets.symmetric(vertical: 3),
//        child: Stack(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//              decoration: BoxDecoration(
//                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
////                  SizedBox(
////                    height: 20,
////                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        "${widget.title}" ,
//                        style: MyColors.styleBold0,
//                      ),
//
//                      SizedBox(height: 4,),
//                      Text(
//                        "رقم الطلب ${widget.num}" ,
//                        style: MyColors.styleNormalSmall,
//                      ),
//
//                    ],
//                  ),
//
//
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//
//                      Row(
//                        children: <Widget>[
//                          Icon(Icons.access_time,size: 16,),
//                          SizedBox(width: 4,),
//                          Text(
//                            "${widget.time}",
//                            style: MyColors.styleBoldSmall,
//                          ),
//                        ],
//                      ),
//
//                      SizedBox(height: 4,),
//
//                      Row(
//                        children: <Widget>[
//                          Icon(Icons.date_range,size: 16,),
//                          SizedBox(width: 4,),
//                          Text(
//                            "${widget.date}" ,
//                            style: MyColors.styleNormalSmall,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//
//              Positioned(
//                    left: 5,
//                    top: 5,
//                    child: InkWell(
//                      onTap: () {
//                        LoadingDialog(widget.scaffold,context).deleteAlert(null, () {
////                          deleteNotification();
//                        });
//                      },
//                      child: Icon(
//                        Icons.cancel,
//                        color: MyColors.blue,
//                        size: 22,
//                      ),
//                    ),
//                  )
//          ],
//        ),
//      ),
//    );
//  }
//}
