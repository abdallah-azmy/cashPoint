import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'dart:io';
import 'package:cashpoint/src/UI/MainWidgets/Comment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Edit_Text_Field.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:cashpoint/src/UI/MainWidgets/mapCard.dart';
import 'package:cashpoint/src/helper/map_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/painting.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCashier extends StatefulWidget {
  var id;
  var apiToken;
  var profileImage;

  final Function getData;

  AddCashier({this.id, this.apiToken, this.getData, this.profileImage});
  @override
  State<StatefulWidget> createState() {
    return AddCashierState();
  }
}

class AddCashierState extends State<AddCashier> {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  var _name;
  var _phone_number;
  var _description;
  var _email;
  var _language;
  var _password;
  var _password_confirmation;
  var _longitude;
  var _latitude;
  var _image;

  var languages = [
    {"lang": "ar", "name": "arabic _ عربي"},
    {"lang": "en", "name": "english _ انجليزي"}
  ];
  var chosenLanguage;
  String lat;
  String long;
  bool _showPassword = false;
  bool showPassword = false;
  var positionPicked;

  var cityController;
  var governrateController;
  var countryController;

  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
//    uploadPic(context);
  }

  addCashier() async {
    print("aappppppiiiii ${widget.apiToken}");
    LoadingDialog(scaffold, context).showLoadingDilaog();
    await ApiProvider(scaffold, context)
        .addCashier(
            apiToken: widget.apiToken,
            name: _name,
            phone: _phone_number,
            image: _image,
            password: _password,
            language: _language,
            description: _description,
            latitude: _latitude,
            longitude: _longitude,
            password_confirmation: _password_confirmation)
        .then((value) async {
      if (value.code == 200) {
        Navigator.pop(context);
        LoadingDialog(scaffold, context)
            .showNotification(localization.text("added_successfully"));
        Future.delayed(Duration(milliseconds: 750), () {
          Navigator.pop(context);
        });
//

      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(scaffold, context).showNotification(value.error[0].value);
      }
    });
  }

  getNameOfLocation(lat, long) async {
    final coordinates = new Coordinates(double.parse(lat), double.parse(long));
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    setState(() {
      cityController = first.locality;
      governrateController = first.adminArea;
      countryController = first.addressLine;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getCities();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Future.delayed(Duration.zero, () {
      this.widget.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: scaffold,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            localization.text("name"),
                            style: MyColors.styleNormal0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        EditTextField(
                          onChange: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          hint: " ",
                          password: false,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            localization.text("phone"),
                            style: MyColors.styleNormal0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        EditTextField(
                          onChange: (value) {
                            setState(() {
                              _phone_number = value;
                            });
                          },
                          hint: " ",
                          password: false,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            localization.text("_description"),
                            style: MyColors.styleNormal0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        EditTextField(
                          onChange: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                          hint: " ",
                          moreTanOneLine: true,
                          minLines: 3,
                          maxLines: 3,
                          height: 80,
                          password: false,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            localization.text("_language"),
                            style: MyColors.styleNormal0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              bottomSheet(context, languages);
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            chosenLanguage == null
                                                ? " "
                                                : "$chosenLanguage",

//                                              details != null
//                                                  ? details.countryCode != null
//                                                  ? "${details.countryCode}"
//                                                  : localization
//                                                  .text("choose country code")
//                                                  : " ",

                                            style: TextStyle(
                                                fontSize: 16,
                                                // fontFamily: "Tajawal",
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          CircleAvatar(
                                            radius: 9,
                                            backgroundColor: Color(0xff727C8E)
                                                .withOpacity(.5),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                localization.text("password"),
                                style: MyColors.styleNormal0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            EditTextField(
                              onChange: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              hint: " ",
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this.showPassword
                                    ? Colors.blue
                                    : Colors.grey,
                                size: 19,
                              ),
                              onIconTap: () {
                                setState(() =>
                                    this.showPassword = !this.showPassword);
                              },
                              password: !this.showPassword,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                localization.text("confirm_password"),
                                style: MyColors.styleNormal0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            EditTextField(
                              onChange: (value) {
                                setState(() {
                                  _password_confirmation = value;
                                });
                              },
                              hint: " ",
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword
                                    ? Colors.blue
                                    : Colors.grey,
                                size: 19,
                              ),
                              onIconTap: () {
                                setState(() =>
                                    this._showPassword = !this._showPassword);
                              },
                              password: !this._showPassword,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MapCard(
                          scaffoldKey: scaffold,
                          picked: positionPicked,
                          onChange: (v) {
                            setState(() {
                              lat = v.latitude.toString();
                              long = v.longitude.toString();
                            });
                            print(v.latitude);
                          },
                          onTap: () {
                            setState(() {
                              _longitude = long ??
                                  Provider.of<MapHelper>(context, listen: false)
                                      .position
                                      .longitude
                                      .toString();
                              _latitude = lat ??
                                  Provider.of<MapHelper>(context, listen: false)
                                      .position
                                      .latitude
                                      .toString();
                              positionPicked = true;
                              getNameOfLocation(_latitude, _longitude);
                            });
                            print(
                                "aaaaaaaaaaaaa $_latitude +++++++++ $_longitude");
                            Navigator.pop(context);
                          },
                          onTextChange: (v) {},
                        ),
                        countryController == null
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: <Widget>[
                                    countryController == null
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Flexible(
                                                  child: Text(
                                                "- $countryController -",
                                                style: MyColors.styleNormal1,
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        SpecialButton(
                          onTap: () {
                            getImage();
                          },
                          text: localization.text("add pic"),
                        ),
                        _image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100.0),
                                      child: Container(color: Colors.white,child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: InkWell(onTap: (){
                                          setState(() {
                                            _image = null ;
                                          });
                                        },child: Icon(Icons.cancel,color: Colors.black,)),
                                      )),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: SpecialButton(
                            onTap: () {
                              print("pressssssssed");
                              if (_latitude == null) {
                                LoadingDialog(scaffold, context)
                                    .showNotification(
                                        localization.text("apply_location"));
                              } else {
                                addCashier();
                              }
                            },
                            text: localization.text("save"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                            ),
                            Text(
                              localization.text("add cashier"),
                              style: MyColors.styleBold2,
                            ),
                            InkWell(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  bottomSheet(
    BuildContext context,
    List<dynamic> list,
  ) {
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
                  child: ListView(children: <Widget>[
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
                                  onTap: () {
                                    setState(() {
                                      _language = list[index]["lang"];
                                      chosenLanguage = list[index]["name"];

                                      print("$_language");
                                    });

                                    Navigator.pop(context);
                                  },
                                  title: Center(
                                    child: Text(
                                      "${list[index]["name"]}",
                                      style: MyColors.styleBold1,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
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
