import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'dart:io';
import 'package:cashpoint/src/UI/MainWidgets/Comment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Edit_Text_Field.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  final scaffold;
  final id;
  ContactUs({
    this.scaffold,
    this.id,
  });
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  var apiToken;
  var details;
  var _message = "";
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });

    getData();
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getGeneralData()
        .then((value) async {
      if (value.code == 200) {
        setState(() {
          details = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }

  contactUs() async {
    if (_message.trim().isEmpty) {
      LoadingDialog(_key, context)
          .showNotification(localization.text("needed_information"));
    } else {
      LoadingDialog(_key, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_key, context)
          .contactUs(apiToken: apiToken, message: _message)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data[0].message);
          Navigator.pop(context);
          LoadingDialog(_key, context)
              .showNotification(localization.text("sent_successfully"));
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_key, context).showNotification(value.error[0].value);
        }
      });
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  callPhone(num) {
    String phoneNumber = "tel:" + num;
    launch(phoneNumber);
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
          key: _key,
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xffF5F6F8),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 9, right: 15, left: 15, bottom: 3),
                        child: Text(
                          localization.text("contact us"),
                          style: MyColors.styleBold2,
                        )),
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 7, right: 8, left: 8),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )))),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      details == null
                          ? Container()
                          : details.twitter == null
                              ? Container()
                              : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "twitter",
                                      style: MyColors.styleBold1,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        _launchURL("${details.twitter}");
                                      },
                                      child: Text(
                                        details == null
                                            ? ""
                                            : details.twitter == null
                                                ? ""
                                                : "${details.twitter}",
                                        style: MyColors.styleNormal0blue,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),


                      details == null
                          ? Container()
                          : details.instagram == null
                          ? Container()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "instagram",
                            style: MyColors.styleBold1,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          InkWell(
                            onTap: (){
                              _launchURL("${details.twitter}");
                            },
                            child: Text(
                              details == null
                                  ? ""
                                  : details.instagram == null
                                  ? ""
                                  : "${details.instagram}",
                              style: MyColors.styleNormal0blue,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),


                      details == null
                          ? Container()
                          : details.facebook == null
                          ? Container()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "facebook",
                            style: MyColors.styleBold1,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          InkWell(
                            onTap: (){
                              _launchURL("${details.facebook}");
                            },
                            child: Text(
                              details == null
                                  ? ""
                                  : details.facebook == null
                                  ? ""
                                  : "${details.facebook}",
                              style: MyColors.styleNormal0blue,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),


                      details == null
                          ? Container()
                          : details.phone == null
                          ? Container()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "phone",
                            style: MyColors.styleBold1,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          InkWell(
                            onTap: (){
                              callPhone("${details.phone}");
                            },
                            child: Text(
                              details == null
                                  ? ""
                                  : details.phone == null
                                  ? ""
                                  : "${details.phone}",
                              style: MyColors.styleNormal0blue,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),

                      SpecialTextField(
                        hint: localization.text("write your message"),
                        onChange: (value) {
                          setState(() {
                            _message = value;
                          });
                        },
                        height: 120.0,
                        minLines: 7,
                        maxLines: 7,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .1,
                      ),
                      SpecialButton(
                        text: localization.text("_send"),
                        height: 47.0,
                        onTap: () {
                          contactUs();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
}
