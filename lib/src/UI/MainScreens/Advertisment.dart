import 'dart:io';

import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainScreens/photoGallaryString.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/My_Orders_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Slider_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class Advertisements extends StatefulWidget {
  final scaffold;
  Advertisements({this.scaffold, });
  @override
  _AdvertisementsState createState() => _AdvertisementsState();
}

class _AdvertisementsState extends State<Advertisements> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<ImageOfOrder> imagesList = [];
  var images = [];
  var loading ;
  var reasons;

  SharedPreferences _prefs;
  var apiToken;
  var _image ;
  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");

    _image == null ? print("null") : chooseAddMethod(context);
  }


  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");

    });
    getData();
    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getAdvertisements(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          images = value.data;
          loading = "done";
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        setState(() {
          loading = "done";
        });

        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }


  addImages(userId,link) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .advertiseWithUs(apiToken: apiToken,image: _image,user_id: userId,link: link )
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        Navigator.pop(context);
        LoadingDialog(_key, context).showNotification(value.data.message);

          getData();


      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }


  deleteImage(imageId) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .deleteImageOfStoreSlider(apiToken: apiToken,image_id: imageId)
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.value);
        Navigator.pop(context);
        LoadingDialog(_key, context).showNotification(value.data.value);
          getData();

      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this._getShared();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xfff5f6f8),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SpecialButton(text: "اضافة اعلان",onTap: (){
            getImage();
          }, ),
        ),

        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: Column(
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 9, right: 15, left: 15, bottom: 3),
                        child: Text(
                         "اعلن لدينا",
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

                loading == null
                    ? Container()
                    : images.length == 0
                    ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                        child: ListView(
                  children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height*.8,
                          child: Center(
                              child: Text(localization.text("no photos"))),
                        ),
                  ],
                ),
                      ),
                    )
                    : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        child: ListView.builder(shrinkWrap: true,
                  itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {


                            imagesList.clear();
                            imagesList.add(ImageOfOrder(image: images[i].image));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhotoGallaryString(
                                      images: imagesList,
                                    )));

                          },
                          child: SliderCard(

                            img: images[i].image,
                              apiToken: apiToken,
                              scaffold: _key,
                              onTap: () {

                              LoadingDialog(_key, context).deleteAlert(null ,
                                  (){
                                    Navigator.pop(context);
                                    deleteImage(images[i].id);
                                  }
                              );


                              },
                              getData: () {
                                getData();
                              }),
                        );
                  },
                  itemCount: images.length,
                ),
                      ),
                    ),
//                    SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  chooseAddMethod(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                    onTap: () {},
                    title: Center(
                      child: Text(
                        "عند الضغط علي الاعلان يقودك",
                        textAlign: TextAlign.center,
                        style: MyColors.styleBold1,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
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
////                        verificationCode = value;
//                      });
//                    },
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);


                      addImages(images[0].userId,null);

                    },
                    text: "الي المتجر",
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      linkAddMethod(context);
                    },
                    text: "الي لينك",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          );
        });
  }



  linkAddMethod(BuildContext context) {
    var link ;
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                ListTile(
//                    onTap: () {},
//                    title: Center(
//                      child: Text(
//                        "عند الضغط علي الاعلان يقودك :",
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
////                        verificationCode = value;
//                      });
//                    },
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialTextField(
                    hint: "اكتب اللينك هنا",
                    onChange: (value){
                      setState(() {
                        link = value ;
                      });
                    },
                  )
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);


                      addImages(null,link);
                    },
                    text: "ارسل",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          );
        });
  }
}

