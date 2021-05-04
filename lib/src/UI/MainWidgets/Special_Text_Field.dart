import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class SpecialTextField extends StatefulWidget {
  final String hint;
  final bool password;
  final keyboardType;
  final Function validator;
  final icon;
  final iconCircleColor;
  final initialValue;
  final onIconTap;
  final height;
  final minLines;
  final maxLines;
  final enabled;
  final  borderRadius;


  final backgroundColor;
  final Function onChange;

  const SpecialTextField(
      {Key key,
      this.password,
      this.enabled,
      this.maxLines,
      this.minLines,
      this.borderRadius,


      this.keyboardType,
      this.backgroundColor,
      this.onIconTap,
      this.icon,
      this.height,
      this.iconCircleColor,
      this.initialValue,
      this.hint,
      this.validator,
      this.onChange})
      : super(key: key);

  @override
  _SpecialTextFieldState createState() => _SpecialTextFieldState();
}

class _SpecialTextFieldState extends State<SpecialTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        height: widget.height ?? 50.0,
//        width: 150,
        child: Theme(
          data: new ThemeData(
            primaryColor: MyColors.orange,
            primaryColorDark: MyColors.orange,
          ),
          child: TextFormField(
            minLines: widget.minLines ?? 1 ,
            enabled: widget.enabled ?? true,
            maxLines: widget.maxLines ?? 1,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 16,
//              fontFamily: "Tajawal",
                fontWeight: FontWeight.bold,
                color: Colors.black),
            keyboardType: widget.keyboardType,
            initialValue: widget.initialValue ?? null,
            onChanged: widget.onChange,
            obscureText: widget.password ?? false,
            validator: widget.validator,
            decoration: InputDecoration(
              fillColor: widget.backgroundColor ?? Colors.white,
              filled: true,
              suffixIcon:widget.icon == null ? null: Padding(
                padding: const EdgeInsets.all(7.0),
                child: InkWell(
                  onTap: widget.onIconTap,
                  child: CircleAvatar(
                    radius: 2,
                    backgroundColor: widget.iconCircleColor ?? Colors.transparent,
                    child: Container(
                      height: 25,
                      width: 25,
                      child: widget.icon,
                    ),
                  ),
                ),
              ),
//                icon: widget.icon ?? null,
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontSize: 16,

//                fontFamily: "Tajawal",
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
//            border: InputBorder.none,
//            focusedBorder: InputBorder.none,
//            enabledBorder: InputBorder.none,
//            errorBorder: InputBorder.none,
//            focusedErrorBorder: InputBorder.none ,
//          disabledBorder: InputBorder.none,

              contentPadding:widget.maxLines == null ? EdgeInsets.only(top: 1, right: 8, left: 8):  EdgeInsets.only(top: 8, right: 10, left: 10),
              border: new OutlineInputBorder(
                borderRadius:  BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 10),


                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
