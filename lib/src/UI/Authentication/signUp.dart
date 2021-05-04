import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreen.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  final phone;
  final countryId;
  SignUp({this.phone, this.countryId});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;

  var _name;
  var _email;
  var password;
  var confirmPassword;
  var _terms = false;
  var deviceToken = "123456789";
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  var logo ;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {

      logo = _prefs.getString("logo");
    });

  }

  signUp() async {
    print("gbna el device topoooooooooken");
    if (deviceToken != null) {
      if(_terms == false){
        LoadingDialog(_scafold, context).showNotification(localization.text("accept_conditions_and_terms"));

      }else{
        LoadingDialog(_scafold, context).showLoadingDilaog();
        await ApiProvider(_scafold, context)
            .signUp(
          phone: widget.phone,
          country_id: widget.countryId,
          password_confirmation: confirmPassword,
          password: password,
          device_token: deviceToken,
          name: _name,
          email: _email,
          terms_conditions: _terms == true ? 1 : 0,
        )
            .then((value) async {
          if (value.code == 200) {
            print('Name >>> ' + value.data.name);

            _prefs.setInt("id", value.data.id);
            _prefs.setBool("loggedIn", true);
            _prefs.setString('name', value.data.name);
            _prefs.setString('phone', value.data.phone);
            _prefs.setInt("active", value.data.active);
            _prefs.setString("image", value.data.image);
            _prefs.setString("api_token", value.data.apiToken);
            _prefs.setString("created_at", value.data.createdAt.toString());

            Navigator.pop(context);

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => MainScreen()), (route) => false);
          } else {
            print('error >>> ' + value.error[0].value);
            Navigator.pop(context);
            LoadingDialog(_scafold, context).showNotification(value.error[0].value);
          }
        });
      }

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
                      child: Center(
                          child: Text(
                        localization.text("sign_up"),
                        style: MyColors.styleBold2white,
                      )),
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
//                    SizedBox(
//                      height: 10,
//                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          SpecialTextField(
                            icon: Icon(
                              Icons.person_outline,
                              color: MyColors.orange,
                              size: 22,
                            ),
                            hint: localization.text("name"),
                            keyboardType: TextInputType.text,
                            iconCircleColor: Colors.grey[200],
                            onChange: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          SpecialTextField(
                            icon: Icon(
                              Icons.mail_outline,
                              color: MyColors.orange,
                              size: 19,
                            ),
                            hint: localization.text("email"),
                            keyboardType: TextInputType.emailAddress,
                            iconCircleColor: Colors.grey[200],
                            onChange: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
//                          SizedBox(height: 7),
//                          InkWell(
//                            onTap: () {
//                              bottomSheet(context, banks, "banks");
//                            },
//                            child: Container(
//                              height: 50,
//                              decoration: BoxDecoration(
//                                border: Border.all(color: Colors.black54),
//                                borderRadius: BorderRadius.all(
//                                  Radius.circular(10),
//                                ),
//                              ),
//                              child: Row(
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.all(5.5),
//                                    child: InkWell(
////                                      onTap: widget.onIconTap,
//                                      child: CircleAvatar(
//                                        radius: 17.5,
//                                        backgroundColor: Colors.grey[200],
//                                        child: Container(
//                                          height: 25,
//                                          width: 25,
//                                          child: Icon(
//                                            Icons.lock,
//                                            size: 22,
//                                            color: MyColors.orange,
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Expanded(
//                                    child: Container(
//                                      child: Padding(
//                                        padding: const EdgeInsets.symmetric(
//                                            horizontal: 4),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(
//                                              localization.text("chooseBank"),
//                                              style: TextStyle(
//                                                  fontSize: 16,
//                                                  // fontFamily: "Tajawal",
//                                                  fontWeight: FontWeight.normal,
//                                                  color: Colors.black),
//                                            ),
//                                            Icon(
//                                              Icons.arrow_drop_down,
//                                              size: 27,
//                                              color: Colors.black,
//                                            )
//                                          ],
//                                        ),
//                                      ),
//
//                                    ),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                          SizedBox(
//                            height: 7,
//                          ),
//                          SpecialTextField(
//                            icon: Icon(
//                              Icons.lock,
//                              size: 22,
//                              color: MyColors.orange,
//                            ),
//                            hint: localization.text("_accountNumber"),
//                            keyboardType: TextInputType.phone,
//                            iconCircleColor: Colors.grey[200],
//                            onChange: (value) {
//                              setState(() {
//                                _accountNumber = value;
//                              });
//                            },
//                          ),
                          SizedBox(height: 7),
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
                          SizedBox(height: 7),
                          SpecialTextField(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showConfirmPassword
                                  ? Colors.blue
                                  : MyColors.orange,
                              size: 19,
                            ),
                            onIconTap: () {
                              setState(() => this._showConfirmPassword =
                                  !this._showConfirmPassword);
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
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: MyColors.orange,
                                value: _terms,
                                onChanged: (newValue) {
                                  setState(() {
                                    _terms = newValue;
                                  });
                                },
                              ),
                              Text(
                                localization.text("accept_the_terms"),
                                style: MyColors.styleNormal0,
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          SpecialButton(
                            onTap: () {
                              signUp();

//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => LoginPage()));
                            },
                            text: localization.text("sing_up"),
                            color: MyColors.orange,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  bottomSheet(BuildContext context, List<dynamic> list, String name) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: list.length == 0
                      ? Center(
                          child: Text(
                            localization.text("no search results"),
                            style: MyColors.styleBold1,
                          ),
                        )
                      : ListView(children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                        onTap: () {},
                                        title: Center(
                                            child: Text(
                                          name == "paymentMethods"
                                              ? list[index]
                                              : list[index].name,
                                          style: MyColors.styleBold1,
                                          textAlign: TextAlign.center,
                                        ))),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ]),
                ),
              ],
            ),
          );
        });
  }
}
