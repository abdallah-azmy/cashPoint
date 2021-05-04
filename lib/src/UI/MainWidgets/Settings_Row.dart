
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../MyColors.dart';

class SettingsRow extends StatefulWidget {
  final String text;
  final textStyle;
  final icon;


  final Function onTap;

  const SettingsRow(
      {Key key, this.text,this.onTap,  this.textStyle, this.icon})
      : super(key: key);

  @override
  _SettingsRowState createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,

      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.icon == null ?    Image.asset(
            "assets/cashpoint/profile2.png",
            fit: BoxFit.fill,
          ) : widget.icon,
          SizedBox(width: 18),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     widget.text ?? localization.text("edit profile"),
                      style:widget.textStyle ?? MyColors.styleNormal15Grey,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffdbdde2),
                      radius: 10,
                      child: Padding(
                        padding:
                        localization.currentLanguage.toString() ==
                            "en"
                            ? EdgeInsets.only(
                          left: 4,
                        )
                            : EdgeInsets.only(
                          right: 4,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 11,

                          color: Color(0xff727c8e),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black12,height: 11,thickness: 1,),
                SizedBox(height: 9,),
              ],
            ),
          )
        ],
      )
    );
  }
}
