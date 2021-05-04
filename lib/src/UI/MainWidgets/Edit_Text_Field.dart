import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class EditTextField extends StatefulWidget {
  final String hint;
  final bool password;
  final keyboardType;
  final Function validator;
  final icon;
  final prefixIcon;
  final minLines;
  final maxLines;
  final onIconTap;
  final bool moreTanOneLine;
  final double height;
  final Function onChange;

  const EditTextField(
      {Key key,
        this.height,
      this.password,
      this.onIconTap,
      this.prefixIcon,

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
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: widget.height ?? 40,
//            padding: widget.moreTanOneLine == null ? EdgeInsets.only(top: 9) :EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),

              child: TextFormField(
                minLines: widget.minLines ?? 1 ,
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
                decoration: InputDecoration(filled: true,fillColor: Colors.white,
                  isDense: true,
                  prefixIcon:widget.prefixIcon == null ? null : Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
//                      onTap: widget.onIconTap,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor:  Color(0xffF5F6F8),
                        child: Container(
                          height: 24,
                          width: 24,
                          child: widget.prefixIcon,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon:widget.icon == null ? null : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: widget.onIconTap,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: Colors.white,
                        child: Container(
                          height: 24,
                          width: 24,
                          child: widget.icon,
                        ),
                      ),
                    ),
                  ),

                  hintText: widget.hint ?? " ",
                  hintStyle: TextStyle(
                      fontSize: 16,
//                    fontFamily: "Tajawal",
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,



                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
