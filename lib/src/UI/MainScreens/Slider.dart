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

class MovingSlider extends StatefulWidget {
  final scaffold;
  final openDrawer;
  MovingSlider({this.scaffold, this.openDrawer});
  @override
  _MovingSliderState createState() => _MovingSliderState();
}

class _MovingSliderState extends State<MovingSlider> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var images = [];
  var loading ;
  var reasons;



  SharedPreferences _prefs;
  var apiToken;
  List<Asset> _images = [];
  List<ImageOfOrder> imagesList = [];
  _getImg() async {
    List<Asset> resultList = await MultiImagePicker.pickImages(
      maxImages: 5 - _images.length,
//      enableCamera: true,
//      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//      materialOptions: MaterialOptions(
//        actionBarColor: "#abcdef",
//        actionBarTitle: "Example App",
//        allViewTitle: "All Photos",
//        useDetailsView: false,
//        selectCircleStrokeColor: "#000000",
//      ),
    );
    setState(() {
      for (int i = 0; i < resultList.length; i++) {
        _images.add(resultList[i]);
      }
    });

    if(_images.length != 0){
      addImages();
    }
  }

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      getData();
    });
    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getStoreSlider(apiToken: apiToken)
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


  addImages() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .addImagesToSlider(apiToken: apiToken,image: _images)
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.length.toString());
        Navigator.pop(context);
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
        Future.delayed(Duration(milliseconds: 750),(){
          getData();
        });
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
          child: SpecialButton(text: localization.text("Add photos"),onTap: (){
            _getImg();
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
                          localization.text("slider"),
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
}

