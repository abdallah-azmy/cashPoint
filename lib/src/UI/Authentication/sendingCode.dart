import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/changePassword.dart';
import 'dart:async';
import 'package:cashpoint/src/UI/Authentication/signUp.dart';
import 'package:cashpoint/src/UI/MainScreens/EditProfile.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendingCode extends StatefulWidget {
  final phone;
  final countryId;
  final typeOfCode;
  SendingCode({this.phone, this.typeOfCode,this.countryId});
  @override
  _SendingCodeState createState() => _SendingCodeState();
}

class _SendingCodeState extends State<SendingCode> {
  String verificationCode;

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();
//
//  var timerCanceled = false;
//  Timer _timer;
//  int _start = 60;
//
  final formKey = GlobalKey<FormState>();

  var timerCanceled = false;
  Timer _timer;
  int _start = 60;

  SharedPreferences _prefs;
  var apiToken ;
  var logInType ;
  var logo ;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      logo = _prefs.getString("logo");
    });
  }

  sendForgetPasswordCode() async {
    if (verificationCode == null) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("short_code"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();

      await ApiProvider(_scafold, context)
          .phoneVerificationForgetPassword(phone: widget.phone, code: verificationCode,type: logInType == "متجر" ? 2 : 1)
          .then((value) async {
        if (value.code == 200) {
          print('correct');
          Navigator.pop(context);
          LoadingDialog(_scafold,context).showNotification(value.data.value);
          Future.delayed(Duration(seconds: 1,milliseconds: 250),(){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChangePassword(phone:widget.phone ,)));

          });
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);

          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }
  sendMobileRegisterCode() async {
    if (verificationCode == null) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("short_code"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();

      await ApiProvider(_scafold, context)
          .phoneVerificationMobileRegister(phone: widget.phone, code: verificationCode,country_id: widget.countryId)
          .then((value) async {
        if (value.code == 200) {
          print('correct');
          Navigator.pop(context);
          LoadingDialog(_scafold,context).showNotification(value.data.value);
          Future.delayed(Duration(seconds: 1,milliseconds: 250),(){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp(phone:widget.phone,countryId: widget.countryId,)));

          });
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);

          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }


  sendChangingPhoneCode() async {
    if (verificationCode == null) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("short_code"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();

      await ApiProvider(_scafold, context)
          .sendCodeForChangingPhone(phone: widget.phone, code: verificationCode,country_id: widget.countryId,apiToken: apiToken,type: logInType == "متجر" ? 2 : 1 )
          .then((value) async {
        if (value.code == 200) {
          print('correct');
          Navigator.pop(context);
          LoadingDialog(_scafold,context).showNotification(value.data.value);
          Future.delayed(Duration(seconds: 1,milliseconds: 250),(){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EditProfile()));

          });
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);

          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }


  resendCodeForMobileRegister() async {

      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .resendCodeForPhoneRegister(phone: widget.phone,country_id: widget.countryId )
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data);

          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification("${value.data}");

//          startTimer();
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });

  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              timerCanceled = true;
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }



//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _getShared();
////    Future.delayed(Duration.zero, () {
////      startTimer();
////    });
//  }
//  @override
//  void dispose() {
////    _timer.cancel();
//    super.dispose();
//  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      startTimer();
      _getShared();
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
////                  "assets/cashpoint/Nbackground.png",
////                  fit: BoxFit.fill,
////                  width: MediaQuery.of(context).size.width,
////                  height: MediaQuery.of(context).size.height,
////                ),
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
                          localization.text("verification_code"),
                          style: MyColors.styleBold1grey,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.text("number"),
                          style: MyColors.styleBold1grey,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.phone == null
                              ? " "
                              : "${widget.phone}",
                          style: MyColors.styleBold3orange,
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${localization.text("you will receive the message within")} $_start",
                          style: MyColors.styleBold1grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
//                            ListTile(
//                                onTap: () {},
//                                title: Center(
//                                    child: Column(
//                                  children: <Widget>[
//                                    SizedBox(
//                                      height: 10,
//                                    ),
//                                    timerCanceled == true
//                                        ? Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.center,
//                                            children: <Widget>[
//
//
//                                              Text(
//                                                localization
//                                                    .text("resend message"),
//                                                style: MyColors.styleNormal1,
//                                              ),
//                                              SizedBox(
//                                                width: 5,
//                                              ),
//                                              InkWell(
//                                                  onTap: () {
////                                                      setState(() {
////                                                        timerCanceled = false;
////                                                        _start = 60;
////                                                      });
////                                                      if (widget.forgetPassword ==
////                                                          true) {
////                                                        resendCodeForForgetPassword();
////                                                      } else {
////                                                        resendCode();
////                                                      }
//                                                  },
//                                                  child: Icon(
//                                                    Icons.refresh,
//                                                  )),
//
//                                            ],
//                                          )
//                                        : Text(
//                                            "${localization.text("you will receive the message within")} $_start",
//                                            style: MyColors.styleNormal1,
//                                          ),
//                                  ],
//                                ))),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
//                              SpecialTextField(
//                                icon: Icon(
//                                  Icons.mail_outline,
//                                  color: Colors.black,
//                                  size: 19,
//                                ),
//                                hint: localization.text("enter code"),
//                                keyboardType: TextInputType.number,
//
//                                onChange: (value) {
//                                  setState(() {
//                                    verificationCode = value;
//                                  });
//                                },
//                              ),

                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Form(
                                key: formKey,
                                child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 5),
                                      child: PinCodeTextField(
//                                      appContext: context,
//                                      pastedTextStyle: TextStyle(
//                                        color: Colors.green.shade600,
//                                        fontWeight: FontWeight.bold,
//                                      ),
                                        length: 4,
//                                      obscureText: true,
//                                      obscuringCharacter: '*',
//                                      blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
//                                      validator: (v) {
//                                        if (v.length < 3) {
//                                          return "I'm from validator";
//                                        } else {
//                                          return null;
//                                        }
//                                      },
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          activeColor: Colors.white,
                                          inactiveColor: MyColors.orange,
                                          disabledColor: MyColors.orange,
                                          inactiveFillColor: MyColors.orange,
                                          selectedColor: Colors.grey[400],
                                          activeFillColor: Colors.white,
                                          selectedFillColor: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 55,
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration:
                                            Duration(milliseconds: 300),
                                        backgroundColor: Colors.transparent,
                                        enableActiveFill: true,
//                                      errorAnimationController: errorController,
//                                      controller: textEditingController,
                                        keyboardType: TextInputType.number,
                                        boxShadows: [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.grey[300],
                                            blurRadius: 10,
                                          )
                                        ],
                                        onCompleted: (v) {
                                          print("Completed");
                                          setState(() {
                                            verificationCode = v;
                                          });
                                        },
                                        // onTap: () {
                                        //   print("Pressed");
                                        // },
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            verificationCode = value;
                                          });
                                        },
                                        beforeTextPaste: (text) {
                                          print("Allowing to paste $text");
                                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                          return true;
                                        },
                                      )),
                              ),
                                  ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SpecialButton(
                                onTap: () {

                                  widget.typeOfCode == "forgetPassword" ?
                                  sendForgetPasswordCode()
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) =>
//                                              ChangePassword()))
                                      :
                                  widget.typeOfCode == "mobileRegister" ? sendMobileRegisterCode() :


                                  sendChangingPhoneCode();
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) =>
//                                              SignUp()));
                                },
                                text: localization.text("Activation"),
                                color: MyColors.orange,
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 6,
                    ),
                    widget.typeOfCode == "mobileRegister" ?     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.text("I didn't receive the code"),
                          style: MyColors.styleBold0grey,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: (){


                            resendCodeForMobileRegister();

                          },
                          child: Text(
                            localization.text("resend_code"),
                            style: MyColors.styleBold3orange,
                          ),
                        ),
                      ],
                    ): Container(),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
