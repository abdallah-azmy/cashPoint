import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTextField extends StatefulWidget {
  final String hint;
  final bool password;
  final keyboardType;
  final Function validator;
  final icon;
  final iconBackGroundColor;
  final  curve;
  final minLines;
  final maxLines;
  final onIconTap;
  final backGroundColor;
  final bool moreTanOneLine;
  final double height;
  final Function onChange;

  const EditTextField(
      {Key key,
        this.height,
        this.password,
        this.curve,
        this.iconBackGroundColor,
        this.onIconTap,
        this.backGroundColor,
        this.minLines,
        this.moreTanOneLine,
        this.maxLines,
        this.keyboardType,
        this.icon,
        this.hint,
        this.validator,
        this.onChange})
      : super(key: key);

  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {




  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.curve ?? 5)),
        borderSide: BorderSide(
          color: Colors.transparent,
        )
    );
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Material(
        color: widget.backGroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(widget.curve ?? 5),
        elevation: 5,
        child: Container(
          height: widget.height ?? 42,
//            padding: widget.moreTanOneLine == null ? EdgeInsets.only(top: 9) :EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
              color: widget.backGroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(widget.curve ?? 5)),

          child: Center(
            child: TextFormField(
              minLines: widget.minLines ?? 1,
              maxLines: widget.maxLines ?? 1,
              style: TextStyle(
                  fontSize: 16,
//                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
              keyboardType: widget.keyboardType,
              onChanged: widget.onChange,
              obscureText: widget.password ?? false,
              validator: widget.validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.backGroundColor ??  Colors.white,
                isDense: true,
                prefixIcon:  widget.icon == null
                    ? null
                    : Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: InkWell(
                    onTap: widget.onIconTap,
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: widget.iconBackGroundColor ?? Color(0xffEEEEEE),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: widget.icon,
                      ),
                    ),
                  ),
                ),
                hintText: widget.hint ?? " ",
//                labelText:   "era",
                hintStyle: TextStyle(
                    fontSize: 16,
//                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                border: new  OutlineInputBorder(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(widget.curve ?? 5),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(top: 4,right: 8,left: 8),
//              focusedBorder: InputBorder.none,
//              enabledBorder: InputBorder.none,
//              errorBorder: InputBorder.none,
//              disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
