import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'dart:io';
import 'package:cashpoint/src/UI/MainWidgets/Comment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Edit_Text_Field.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EditProfile extends StatefulWidget {
  final scaffold;
  final getData;
  final id;
  EditProfile({
    this.scaffold,
    this.getData,
    this.id,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  File _image;
  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  var details;
  var loading = true;

  var shownCountryCode;
  var countries = [];

  var _currentPassword = "";
  var _newPassword = "";
  var _confirmNewPassword = "";
  var _name = "";
  var _phone = "";
  var _email = "";
  var _countryId;
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
            :    logInType == "متجر"
            ?

        details.logo == null
                ? " "
                : "${details.logo}"
        :
        details.image == null
            ? " "
            : "${details.image}"
        ,
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
    logInType == "متجر"
        ? await ApiProvider(_scafold, context)
        .getAllDataForStore(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          details = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    }):

    await ApiProvider(_scafold, context)
        .getAllDataForClient(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          details = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });

    await ApiProvider(_scafold, context)
        .getCountries(networkError: false)
        .then((value) async {
      if (value.code == 200) {
        print('correct');
//        Navigator.pop(context);

        setState(() {
          countries = value.data;
        });
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  changePassword() async {
    if (_currentPassword.trim().isEmpty ||
        _newPassword.trim().isEmpty ||
        _confirmNewPassword.trim().isEmpty) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("needed_information"));
    } else if (_newPassword.length < 6 || _confirmNewPassword.length < 6) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("short_password"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .changePassword(
              current_password: _currentPassword,
              apiToken: apiToken,
              password_confirmation: _confirmNewPassword,
              new_password: _newPassword)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data.value);

          Navigator.pop(context);
          LoadingDialog(_scafold, context).showNotification(value.data.value);

//          getData();

        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }

//
//  getCountries() async {
//    LoadingDialog(_scafold, context).showLoadingDilaog();
//    await ApiProvider(_scafold, context)
//        .getCountries()
//        .then((value) async {
//      if (value.code == 200) {
//        print('correct');
//        Navigator.pop(context);
//
//        setState(() {
//          countries = value.data ;
//        });
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//
//        LoadingDialog(_scafold, context)
//            .showNotification(value.error[0].value);
//      }
//    });
//
//  }

  changePhone() async {
    if (_phone.trim().isEmpty) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("needed_information"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .changePhoneNumber(
              phone: _phone,
              apiToken: apiToken,
              country_id: _countryId,
              type: logInType == "متجر" ? 2 : 1)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data.value);

          Navigator.pop(context);
          LoadingDialog(_scafold, context).showNotification(value.data.value);

          Future.delayed(Duration(seconds: 1, milliseconds: 250), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendingCode(
                          phone: _phone,
                          typeOfCode: "changePhone",
                          countryId: _countryId,
                        )));
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

  editProfile() async {
    if (_name.trim().isEmpty && _email.trim().isEmpty && _image == null) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("needed_information"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .editClintProfile(apiToken: apiToken, image: _image, name: _name,email:_email )
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data.name);

          _image == null ? print("no pic") : _prefs.setString("image", value.data.image);
          _prefs.setString('name', value.data.name);

          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(localization.text("edit_success"));

          getData();
        } else {
          print('error >>> ' + value.error[0].value);
          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(value.error[0].value);
        }
      });
    }
  }

  editProfileForStore() async {
    if (_name.trim().isEmpty && _email.trim().isEmpty && _image == null) {
      LoadingDialog(_scafold, context)
          .showNotification(localization.text("needed_information"));
    } else {
      LoadingDialog(_scafold, context).showLoadingDilaog();
      print("gbna el device topoooooooooken");
      await ApiProvider(_scafold, context)
          .editStoreProfile(
              apiToken: apiToken,
              image: _image,
              name: _name,
              description: _description)
          .then((value) async {
        if (value.code == 200) {
          print('Name >>> ' + value.data.name);

          _image == null ? print("no pic") : _prefs.setString("image", value.data.logo);
          _prefs.setString('name', value.data.name);
          print(">>>>>>>>>>>> ${value.data.name}");
          print(">>>>>>>>>>>> ${value.data.logo}");

          Navigator.pop(context);
          LoadingDialog(_scafold, context)
              .showNotification(localization.text("edit_success"));
          getData();
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.getData() ;
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
                                    logInType == "متجر"
                                        ? Container() :     Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                              details == null
                                                  ? ""
                                                  : details.email == null
                                                  ? ""
                                                  : "${details.email}",
                                          style: MyColors.styleNormal0,
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
                                    ? "الاسم"
                                    : details.name == null
                                        ? "الاسم"
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
                              logInType == "متجر"
                                  ? Container() :    Column(
                                children: [
                                  Divider(),
                                  EditTextField(
                                    hint: details == null
                                        ? "البريد الالكتروني"
                                        : details.email == null
                                        ? "البريد الالكتروني"
                                        : "${details.email}",
                                    keyboardType: TextInputType.emailAddress,
                                    onChange: (value) {
                                      setState(() {
                                        _email = value;
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
                              ),
                              logInType == "متجر"
                                  ? Column(
                                      children: [
                                        Divider(),
                                        EditTextField(
                                          hint: details == null
                                              ? "الوصف"
                                              : details.description == null
                                              ? "الوصف"
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
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SpecialButton(
                          text: "تعديل البيانات",
                          height: 47.0,
                          onTap: () {
                            logInType == "متجر"
                                ? editProfileForStore()
                                : editProfile();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                    ? " "
                                    : details.phone == null
                                        ? " "
                                        : "${details.phone}",
                                onChange: (value) {
                                  setState(() {
                                    _phone = value;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                icon: Image.asset(
                                  "assets/cashpoint/suggest.png",
                                  fit: BoxFit.fill,
                                  height: 22,
                                  width: 18,
                                ),
                              ),

                              Divider(),

//                          SizedBox(height: 15),

                              InkWell(
                                onTap: () {
                                  bottomSheet(context, countries, "countries");
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
//                                border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
//                                      onTap: widget.onIconTap,
                                          child: CircleAvatar(
                                            radius: 17.5,
                                            backgroundColor: Colors.grey[200],
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: Icon(
                                                Icons.flag,
                                                size: 22,
                                                color: MyColors.orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  shownCountryCode ??
                                                      localization.text(
                                                          "choose country code"),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      // fontFamily: "Tajawal",
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 27,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SpecialButton(
                          text: "تغيير رقم الموبايل",
                          height: 47.0,
                          onTap: () {
                            changePhone();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localization.text("change_password"),
                              style: MyColors.styleBold2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              EditTextField(
                                hint: localization.text("current_password"),
                                password: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.text,
                                onChange: (value) {
                                  setState(() {
                                    _currentPassword = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              EditTextField(
                                hint: localization.text("new_password"),
                                onChange: (value) {
                                  setState(() {
                                    _newPassword = value;
                                  });
                                },
                                password: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              EditTextField(
                                hint: localization.text("confirm_nem_password"),
                                password: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.text,
                                onChange: (value) {
                                  setState(() {
                                    _confirmNewPassword = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SpecialButton(
                          text: localization.text("save"),
                          height: 47.0,
                          onTap: () {
                            changePassword();
                          },
                        )
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
                                      _countryId = list[index].id;
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
