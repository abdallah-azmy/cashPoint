import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordCashier extends StatefulWidget {
  final phone ;
  final logInType;

  ChangePasswordCashier({this.phone,this.logInType});
  @override
  _ChangePasswordCashierState createState() => _ChangePasswordCashierState();
}

class _ChangePasswordCashierState extends State<ChangePasswordCashier> {

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  var password ="";
  var confirmPassword ="";

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
//  var logInType ;
  var logo ;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
//      logInType = _prefs.getString("login");
      logo = _prefs.getString("logo");
    });
  }



  resetPassword() async {

    if (password.trim().isEmpty || confirmPassword.trim().isEmpty) {
      LoadingDialog(_scafold,context)
          .showNotification(localization.text("needed_information"));
    }else if (password.length < 6){
      LoadingDialog(_scafold,context)
          .showNotification(localization.text("short_password"));

    } else {
      LoadingDialog(_scafold,context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .resetPasswordForCashier(password: password,password_confirmation: confirmPassword,phone: widget.phone )
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data);

          Navigator.pop(context);
          LoadingDialog(_scafold,context).showNotification(value.data);
          Future.delayed(Duration(seconds: 1,milliseconds: 250),(){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));

          });

        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold,context).showNotification(value.error[0].value);
        }
      });

    }

  }




@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getShared();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: _scafold,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
//                Image.asset(
//                  "assets/cashpoint/Nbackground.png",
//                  fit: BoxFit.fill,
//                  width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height,
//                ),
                ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: MyColors.darkRed),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              width: 209,
                              height: 146,
                              fit: BoxFit.fill,
//              color: Colors.transparent,
                              imageUrl: logo == null
                                  ? " "
                                  : "$logo",
                              placeholder: (context, url) => new Container(
                                height: 30,
                                width: 30,
//                                      color: MyColors.grey,
                                child: Center(
                                    child: SpinKitChasingDots(
                                      color: Colors.white,
                                      size: 30.0,
                                    )),
                              ),
                              placeholderFadeInDuration:
                              Duration(milliseconds: 500),
                              errorWidget: (context, url, error) =>
                              new Container(
                                height: 30,
                                width: 30,
                                child: Center(
                                    child: SpinKitChasingDots(
                                      color: Colors.white,
                                      size: 30.0,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: MyColors.darkRed,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: MyColors.darkRed,
                        borderRadius: BorderRadius.only(
//                        bottomLeft:  Radius.circular(80),
                        ),
                      ),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.text("change_password"),
                          style: MyColors.styleBold2grey,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .12,
                          ),
                          SpecialTextField(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword
                                  ? Colors.blue
                                  : MyColors.orange,
                              size: 19,
                            ),
                            onIconTap: () {
                              setState(() =>
                              this._showPassword = !this._showPassword);
                            },
                            password: !this._showPassword,
                            iconCircleColor: Colors.grey[200],
                            hint: localization.text("password"),

                            keyboardType: TextInputType.text,
                            onChange: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          SizedBox(height: 15),

                          SpecialTextField(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showConfirmPassword
                                  ? Colors.blue
                                  : MyColors.orange,
                              size: 19,
                            ),
                            onIconTap: () {
                              setState(() =>
                              this._showConfirmPassword = !this._showConfirmPassword);
                            },
                            password: !this._showConfirmPassword,
                            iconCircleColor: Colors.grey[200],
                            hint: localization.text("confirm_password"),

                            keyboardType: TextInputType.text,
                            onChange: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                          ),
                          SizedBox(height: 15),

                          SpecialButton(
                            onTap: () {

                              resetPassword();

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => LoginPage()));

                            },
                            text: localization.text("save"),
                            color: MyColors.orange,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
//
//  enterVerificationCode(BuildContext context, var email, String txt) {
//    return showModalBottomSheet<dynamic>(
//        isScrollControlled: true,
//        backgroundColor: Colors.white,
//        context: context,
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//        builder: (BuildContext bc) {
//          return Padding(
//            padding: MediaQuery.of(context).viewInsets,
//            child: Padding(
//              padding: const EdgeInsets.only(top: 20.0),
//              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                ListTile(
//                    onTap: () {},
//                    title: Center(
//                      child: Text(
//                        txt,
//                        textAlign: TextAlign.center,
//                        style: MyColors.styleBold1,
//                      ),
//                    )),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: SpecialTextField(
//                    icon: Icon(
//                      Icons.mail_outline,
//                      color: Colors.black,
//                      size: 19,
//                    ),
//                    hint: "ادخل الكود",
//                    keyboardType: TextInputType.emailAddress,
//                    onChange: (value) {
//                      setState(() {
//                        verificationCode = value;
//                      });
//                    },
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: SpecialButton(
//                    onTap: () {
////                      sendCode();
//                    },
//                    text: "ارسل",
//                  ),
//                ),
//              ]),
//            ),
//          );
//        });
//  }
}
