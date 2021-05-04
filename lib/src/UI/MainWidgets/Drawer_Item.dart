//import 'package:cashpoint/src/MyColors.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class DrawerItem extends StatefulWidget {
//  final String text;
//  final  color;
//  final  textColor;
//  final  onTap;
//
//  const DrawerItem({Key key, this.text, this.onTap,this.color,this.textColor}) : super(key: key);
//
//  @override
//  _DrawerItemState createState() => _DrawerItemState();
//}
//
//class _DrawerItemState extends State<DrawerItem> {
//  @override
//  Widget build(BuildContext context) {
//    return   Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
//      child: InkWell(
//        onTap: widget.onTap,
//        child: Container(
//          height: 35,
//          child: Row(
//            children: <Widget>[
//              Text(
//                widget.text,
//                style: MyColors.styleNormal2,
//              ),
//            ],
//          ),
//        ),
//
//      ),
//    );
//  }
//}
