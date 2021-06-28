import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'dart:io';
import 'package:cashpoint/src/UI/MainWidgets/Comment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Edit_Text_Field.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
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

class EditProfileCashier extends StatefulWidget {
  final scaffold;
  final getData;
  final id;
  EditProfileCashier({
    this.scaffold,
    this.getData,
    this.id,
  });
  @override
  _EditProfileCashierState createState() => _EditProfileCashierState();
}

class _EditProfileCashierState extends State<EditProfileCashier> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  File _image;
  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  var details;
  var loading = true;

  var shownCountryCode;

  var positionPicked;
  var cityController;
  var governrateController;
  var countryController;
  String lat;
  String long;

  var _longitude;
  var _latitude;
  var _name = "";
  var _email = "";
  var _description;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      loading = false;
    });
    print("$apiToken");
    getData();
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

  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
//    uploadPic(context);
  }

  imageConditions() {
    if (_image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
      );
    } else if (details != null) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: details == null
            ? " "
            : logInType == "متجر"
                ? details.logo == null
                    ? " "
                    : "${details.logo}"
                : details.image == null
                    ? " "
                    : "${details.image}",
        placeholder: (context, url) => new Container(
          color: MyColors.grey,
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => new Container(
          color: MyColors.grey,
//          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        color: MyColors.grey,
        child: CircularProgressIndicator(),
      );
    }
  }

  getData() async {
    LoadingDialog(_scafold, context).showLoadingDilaog();

    await ApiProvider(_scafold, context)
        .getAllDataForCashier(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          details = value.data;
        });
        getNameOfLocation(details.latitude, details.longitude);
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
      }
    });
  }

  editProfile() async {
    if (_name.trim().isEmpty &&
        _description == null &&
        _image == null &&
        _longitude == null &&
        _latitude == null) {
      LoadingDialog(_scafold, context)
          .alertPopUp(localization.text("needed_information"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .editCashierProfile(
              apiToken: apiToken,
              image: _image,
              name: _name,
              description: _description,
              longitude: _longitude,
              latitude: _latitude)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data.name);

          _image == null
              ? print("no pic")
              : _prefs.setString("image", value.data.image);
          _prefs.setString('name', value.data.name);

          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .alertPopUp(localization.text("edit_success"));

          getData();
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .alertPopUp(value.error[0].value);
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.getData();
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
          body: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: SafeArea(
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
                            localization.text("edit_account"),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipOval(
                                      child: imageConditions(),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 2,
                                      right: 2,
                                      child: InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.green,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          details == null
                                              ? " "
                                              : details.name == null
                                                  ? " "
                                                  : "${details.name}",
                                          style: MyColors.styleBoldBig,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              EditTextField(
                                hint: details == null
                                    ? localization.text("name")
                                    : details.name == null
                                        ? localization.text("name")
                                        : "${details.name}",
                                onChange: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                                icon: Image.asset(
                                  "assets/cashpoint/suggest.png",
                                  fit: BoxFit.fill,
                                  height: 22,
                                  width: 22,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              Column(
                                children: [
                                  Divider(),
                                  EditTextField(
                                    hint: details == null
                                        ? localization.text("_description")
                                        : details.description == null
                                            ? localization.text("_description")
                                            : "${details.description}",
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    minLines: 4,
                                    moreTanOneLine: true,
                                    height: 70,
                                    onChange: (value) {
                                      setState(() {
                                        _description = value;
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/cashpoint/suggest.png",
                                      fit: BoxFit.fill,
                                      height: 22,
                                      width: 22,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MapCard(
                          scaffoldKey: _scafold,
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
                          height: 15,
                        ),
                        SpecialButton(
                          text: localization.text("edit_data"),
                          height: 47.0,
                          onTap: () {
                            editProfile();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
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
                                    Navigator.pop(context);
                                    setState(() {
//                                      _countryId = list[index].id;
                                      shownCountryCode =
                                          "${list[index].name}  ${list[index].code}";
                                    });
                                  },
                                  title: Center(
                                    child: Text(
                                      "${list[index].name}  ${list[index].code}",
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
