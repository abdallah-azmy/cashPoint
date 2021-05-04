import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class LocationCard extends StatefulWidget {
  final num;
  final location;
  final Function onTap;
  final id;
  final apiToken;
  final scaffold;
  final Function getData;

  const LocationCard(
      {Key key,
      this.apiToken,
      this.location,
      this.scaffold,
      this.onTap,
      this.num,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  deleteNotification() async {
//    Navigator.pop(context);
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .deleteLocation(apiToken: widget.apiToken,location_id: widget.id)
//        .then((value) async {
//      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.value);
//
//
//        Navigator.pop(context);
//        LoadingDialog(widget.scaffold,context)
//            .showNotification(value.data.value);
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
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "# ${widget.num}",
                            style: MyColors.styleBold0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "${widget.location}",
                            style: MyColors.styleNormal2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      LoadingDialog(widget.scaffold, context).deleteAlert(null,
                              () {
                          deleteNotification();
                          });
                    },
                    child: Icon(
                      Icons.cancel,
                      color: MyColors.blue,
                      size: 26,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: widget.onTap,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: MyColors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
