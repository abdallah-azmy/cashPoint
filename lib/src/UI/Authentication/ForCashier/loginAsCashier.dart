import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/UI/Authentication/ForCashier/forgetPasswordForCashier.dart';
import 'package:cashpoint/src/UI/Intro/loginType.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreenCashier.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cashpoint/src/MyColors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreen.dart';

import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPageForCashier extends StatefulWidget {
  @override
  _LoginPageForCashierState createState() => _LoginPageForCashierState();
}

class _LoginPageForCashierState extends State<LoginPageForCashier> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _phone= "" ;
  String _password= "" ;
  String _deviceToken ;
  bool _showPassword = false;
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();


  var logo ;
  SharedPreferences _prefs;
  var apiToken;
  var logInType = "كاشير";
  var loading = true;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    _deviceToken = await _firebaseMessaging.getToken();
    print("device Tooooooooooken : $_deviceToken");
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      logo = _prefs.getString("logo");
      loading = false ;
    });
//    getData();
    print("api_token >>>>> $apiToken");
  }


  selectLanguage(lang,apiToken) async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .changeLanguageCashier(apiToken: apiToken,language:lang )
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.message);
//
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

//        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  login() async {

    if (_phone.trim().isEmpty ||_password.trim().isEmpty || _password.length < 6) {
      LoadingDialog(_scafold,context)
          .showNotification(localization.text("error_logIn_phone"));
    } else {
      LoadingDialog(_scafold,context).showLoadingDilaog();

      if (_deviceToken != null) {
        print("gbna el device topoooooooooken");
        await ApiProvider(_scafold, context)
            .cashierLogin(password: _password, device_token: _deviceToken,phone: _phone, )
            .then((value) async {
          if (value.code == 200) {
            print('Name >>> ' + value.data.name);

            _prefs.setString('login', "كاشير");
            _prefs.setInt("id", value.data.id);
            _prefs.setBool("loggedIn", true);
            _prefs.setString('name', value.data.name);
            _prefs.setString('phone', value.data.phone);
            _prefs.setInt("active", value.data.active);
            _prefs.setString("image", value.data.image);
            _prefs.setString("api_token", value.data.apiToken);
            _prefs.setString("created_at", value.data.createdAt.toString());


            selectLanguage(localization.currentLanguage.toString(),value.data.apiToken);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainScreenCashier()),
                    (route) => false);
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => MainScreen()));

          } else {
            print('error >>> ' + value.error[0].value);
            Navigator.pop(context);

            if(value.error[0].value == "بيانات الاعتماد هذه غير متطابقة مع البيانات المسجلة لدينا."){
              LoadingDialog(_scafold,context).showNotification(localization.text("This data is not recorded"));
            }else{
              LoadingDialog(_scafold,context).showNotification(value.error[0].value);
            }
          }
        });
      }
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getShared();
  }

  @override
  Widget build(BuildContext context) {
    return loading == true ? Center(child: CircularProgressIndicator(),) : Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: _scafold,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[100],
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
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .09,
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                localization.text("log in as cashier"),
                                style: MyColors.styleNormal2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SpecialTextField(
                            icon: Icon(
                              Icons.phone_android,
                              color: MyColors.orange,
                              size: 19,
                            ),
                            hint:localization.text("phone_number"),
                            keyboardType: TextInputType.phone,
                            iconCircleColor: Colors.grey[200],
                            onChange: (value) {
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
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
                                _password = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetPasswordForCashier()));
                                    },
                                    child: Text(
                                      localization.text("forget_password"),
                                      style: MyColors.styleNormalSmallOrange,
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          SpecialButton(
                            onTap: () async {



                                login();

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => MainScreen()));
                            },
                            text: localization.text("login"),
                            textSize: 16,
                            color: MyColors.orange,
                            height: 47.0,
                          ),



                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

//              InkWell(
//                onTap: () => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => SignUpPage())),
//                child: Text(
//                  localization.text("sign_up"),
//                  style: TextStyle(
//                      fontSize: 15,
//                      fontFamily: "RB",
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white),
//                  textAlign: TextAlign.center,
//                ),
//              ),

                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }

//  _onSave() {
//    final isValid = _form.currentState.validate();
//    if (!isValid) {
//      setState(() {
//        Provider.of<LoginProvider>(context).loading = false;
//      });
//      return;
//    }
//    _form.currentState.save();
//
//    Provider.of<LoginProvider>(context, listen: false)
//        .login(email, password, fcmToken, context);
//  }
}
