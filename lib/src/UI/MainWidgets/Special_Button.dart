
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialButton extends StatefulWidget {
  final String text;
  final color;
  final textColor;
  final icon;
  final width;
  final height;
  final double textSize;

  final Function onTap;

  const SpecialButton(
      {Key key, this.text,this.height, this.width,this.textSize,this.onTap, this.color, this.textColor, this.icon})
      : super(key: key);

  @override
  _SpecialButtonState createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,

      child: Container(
        height: widget.height ?? 41,
        width : widget.width ?? null ,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.color ?? MyColors.orange),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              widget.icon != null ?
              Padding(
                child: widget.icon,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ) : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: widget.textSize ?? 18,
//                        fontFamily: "Tajawal",
                      fontWeight: FontWeight.normal,
                      color: widget.textColor ?? Colors.white),
                ),
              ),

              widget.icon != null ?
              Padding(
                child: widget.icon,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ) : Container(),

            ],
          ),
        ),
      ),
    );
  }
}
