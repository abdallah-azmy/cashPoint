

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebaseNotification/appLocalization.dart';

class SpecialTextFieldSearch extends StatefulWidget {
  final String hint;
  final bool password;
  final keyboardType;
  final Function validator;
  final icon;
  final onIconTap;
  final filledColor;
  final Function onChange;

  const SpecialTextFieldSearch(
      {Key key,
        this.password,
        this.keyboardType,
        this.filledColor,
        this.onIconTap,
        this.icon,
        this.hint,
        this.validator,
        this.onChange})
      : super(key: key);

  @override
  _SpecialTextFieldSearchState createState() => _SpecialTextFieldSearchState();
}

class _SpecialTextFieldSearchState extends State<SpecialTextFieldSearch> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Container(
        height: 40,
//        width: 150,
        child: TextFormField(
          style: TextStyle(
              fontSize: 16,
//              // fontFamily: "Tajawal",
              fontWeight: FontWeight.bold,
              color: Colors.black),
          keyboardType: widget.keyboardType,
          onChanged: widget.onChange,
          obscureText: widget.password ?? false,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: widget.filledColor != null ? true : false,
            fillColor: widget.filledColor,

            suffixIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: widget.onIconTap,
                child: widget.icon,
              ),
            ),
//                icon: widget.icon ?? null,
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontSize: 17,
//                // fontFamily: "Tajawal",
                fontWeight: FontWeight.normal,
                color: Colors.black),
//            border: InputBorder.none,
//            focusedBorder: InputBorder.none,
//            enabledBorder: InputBorder.none,
//            errorBorder: InputBorder.none,
//            focusedErrorBorder: InputBorder.none ,
//          disabledBorder: InputBorder.none,

            contentPadding: EdgeInsets.only(top: 0, right: 10, left: 10),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            )
          ),
        ),
      ),
    );
  }
}
