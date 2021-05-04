import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class NotificationCard extends StatefulWidget {
  final time;
  final read;
  final content;
  final title;
  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const NotificationCard(
      {Key key,
        this.apiToken,
        this.scaffold,
        this.onTap,
        this.title,
        this.content,
        this.orderId,
        this.time,
        this.read,
        this.getData,
        this.id})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
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
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 14 ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(72.0),
                child: CircleAvatar(
                  backgroundColor:widget.read != false ? MyColors.orange : Color(0xffB6B7B7),
                  radius: 21,
                  child: Image.asset(
                    "assets/cashpoint/true.png",
                    fit: BoxFit.fill,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              SizedBox(width: 7,),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "${widget.title}" ,
                            style: MyColors.styleBold0,
                          ),
                        ),


                        Column(
                          children: [
                            SizedBox(height: 4,),
                            Text(
                              "${widget.time}",
                              style: MyColors.styleBoldSmall,
                            ),
                            SizedBox(height: 2,),
                          ],
                        ),
                      ],
                    ),



                    Text(
                      "${widget.content}" ,
                      style: MyColors.styleNormalSmall,
                    ),
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
