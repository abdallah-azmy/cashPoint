import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color txtColor;
  final double heigh;

  const CustomBtn(
      {Key key,
      @required this.text,
      @required this.onTap,
      @required this.color,
      this.txtColor, this.heigh})
      : super(key: key);

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heigh,
      child: MaterialButton(
        onPressed: widget.onTap,
        color: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(color: widget.txtColor),
          ),
        ),
      ),
    );
  }
}
