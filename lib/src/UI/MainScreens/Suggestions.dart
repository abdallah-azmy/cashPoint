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

class Suggestions extends StatefulWidget {
  final scaffold;
  final id;
  Suggestions({
    this.scaffold,
    this.id,
  });
  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  var apiToken;
  var _message="";
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });
  }


  sendSuggestion() async {
    if (_message.trim().isEmpty) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("needed_information"));
    }else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .suggestStore(
          apiToken: apiToken,
          description: _message)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data[0].description);
          Navigator.pop(context);
          LoadingDialog(_scafold, context).showNotification(localization.text("sent_successfully"));
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
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
                          localization.text("Suggestions"),
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
                    children: [

                      SizedBox(height: MediaQuery.of(context).size.width * .3 ,),

                      SpecialTextField(hint: localization.text("Write your suggestion here"),onChange: (value){
                        setState(() {
                          _message = value ;
                        });
                      },height: 120.0,minLines: 7,maxLines: 7,),
                      SizedBox(height: MediaQuery.of(context).size.width * .1 ,),
                      SpecialButton(text: localization.text("_send"),height: 47.0,onTap: (){
                        sendSuggestion();
                      },),
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
