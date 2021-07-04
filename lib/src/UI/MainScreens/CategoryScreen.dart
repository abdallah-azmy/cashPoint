import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainScreens/CategoryItemDetails.dart';
import 'package:cashpoint/src/UI/MainWidgets/Category_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Settings_Row.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:cashpoint/src/helper/map_helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  final scaffold;
  final id;
  final img;
  final homeCategories;
  final categoryName;
  CategoryScreen({
    this.scaffold,
    this.id,
    this.img,
    this.homeCategories,
    this.categoryName,
  });
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String phone;

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var category = [];
  var pinnedCategory = [];
  var loading;
  var loadingPinned;

  var allHomeCategories = [];

  var _loading = true;
  var _image;
  SharedPreferences _prefs;
  var apiToken;
  var details;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      loading = null;
    });
    getAllPinnedStoresOfCategory().then((value) {
      Provider.of<MapHelper>(context, listen: false)
          .getLocation()
          .then((value) async {
        if (Provider.of<MapHelper>(context, listen: false).position == null) {
//          LoadingDialog(_scafold, context).showNotification(
//              localization.text("Location must be specified"));

        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
          getDataByLat(
//              lat:
//          Provider.of<MapHelper>(context, listen: false)
//              .position
//              .latitude
//              .toString()
//              ,
//              long:  Provider.of<MapHelper>(context, listen: false)
//                  .position
//                  .longitude
//                  .toString()
          );

        } else {
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          getDataByLat(lat: Provider.of<MapHelper>(context, listen: false)
              .position
              .latitude
              .toString()
              ,
             long:  Provider.of<MapHelper>(context, listen: false)
                 .position
                 .longitude
                 .toString()
          );
        }
      });
    });

    print("api_token >>>>> $apiToken");
  }

  getAllPinnedStoresOfCategory() async {
    setState(() {
      pinnedCategory = [];
      loadingPinned = null;
    });
    LoadingDialog(_scafold, context).showLoadingDilaog();
    print("api_token >>>>> $apiToken");
    await ApiProvider(_scafold, context)
        .getAllStoresOfCategory(
//      apiToken: apiToken,
      category_id: widget.id,
    )
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
//          pinnedCategory = value.data.map((m)=> m.arranging != null ).toList();
          pinnedCategory =
              value.data.where((x) => x.arranging != null).toList();
          pinnedCategory.sort((m1, m2) {
            var r = m1.arranging.compareTo(m2.arranging);
            return r;
          });
//          pinnedCategory = pinnedCategory.reversed.toList();
          loadingPinned = "done";
        });

        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        setState(() {
          loadingPinned = "done";
        });
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  getAllStoresOfCategory() async {
    setState(() {
      category = [];
      loading = null;
    });
    LoadingDialog(_scafold, context).showLoadingDilaog();
    print("api_token >>>>> $apiToken");
    await ApiProvider(_scafold, context)
        .getAllStoresOfCategory(
//      apiToken: apiToken,
      category_id: widget.id,
    )
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          category = value.data;
//          category = value.data;

          for (var i = 0; i < pinnedCategory.length; i++) {
            category.removeWhere((item) => item.id == pinnedCategory[i].id);
          }

//          pinnedCategory = value.data.map((m)=> m!= null ).toList();
          loading = "done";
        });
//        print("${pinnedCategory.length}");
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        setState(() {
          loading = "done";
        });
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  getDataByLat({lat, long}) async {
    setState(() {
      category = [];
      loading = null;
    });
    LoadingDialog(_scafold, context).showLoadingDilaog();
    print("api_token >>>>> $apiToken");
    await ApiProvider(_scafold, context)
        .getStoresOfCategoryWithLat(
//            apiToken: apiToken,
            category_id: widget.id,
            longitude: long,
            latitude: lat)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          category = value.data;
          for (var i = 0; i < pinnedCategory.length; i++) {
            category.removeWhere((item) => item.id == pinnedCategory[i].id);
          }
          loading = "done";
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        setState(() {
          loading = "done";
        });
        if(value.error[0].key == "latitude"){
          LoadingDialog(_scafold, context).showNotification(localization.text("Location must be specified"));
        }else{
          LoadingDialog(_scafold, context).showNotification(value.error[0].value);
        }

      }
    });
  }

  @override
  void initState() {
    super.initState();
    _image = NetworkImage("${widget.img}");
    _image.resolve(new ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          print('Networkimage is fully loaded and saved');
          setState(() {
            _loading = false;
          });
          // do something
        },
      ),
    );

    this._getShared();
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
              return _getShared();
            },
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                            color: Colors.black,
//                      borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(80),
//                      ),
                            image: _loading == true
                                ? DecorationImage(
                                    image: AssetImage(
                                      "assets/cashpoint/giphy.gif",
                                    ),
                                    alignment: Alignment.center,
                                    scale: 7

//                          fit: BoxFit.contain
                                    )
                                : DecorationImage(
                                    image: NetworkImage("${widget.img}"),
                                    fit: BoxFit.fill)),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            color: Colors.black54.withOpacity(.5),
//                      height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, right: 10, left: 10, bottom: 3),
                                    child: Text(
                                      "${widget.categoryName}",
                                      style: MyColors.styleBold2white,
                                    )),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        chooseFiltrationMethod(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9, right: 10, left: 10),
                                        child: Image.asset(
                                          "assets/cashpoint/filter.png",
                                          fit: BoxFit.fill,
                                          height: 22,
                                          width: 22,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 7, right: 8, left: 8),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 30,
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                )))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F6F8),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.homeCategories.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 4),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            CategoryScreen(
                                                                id: widget
                                                                    .homeCategories[
                                                                        i]
                                                                    .id,
                                                                categoryName: widget
                                                                    .homeCategories[
                                                                        i]
                                                                    .name,
                                                                img: widget
                                                                    .homeCategories[
                                                                        i]
                                                                    .image,
                                                                homeCategories:
                                                                    widget
                                                                        .homeCategories)));
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: widget
                                                                  .categoryName ==
                                                              widget
                                                                  .homeCategories[
                                                                      i]
                                                                  .name
                                                          ? MyColors.orange
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Text(
                                                      "${widget.homeCategories[i].name}")),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),
//                  loading == null
//                      ? Container()
//                      : pinnedCategory.length == 0
//                          ? Center(
//                              child: Text("لا توجد متاجر"),
//                            )
//                          :
                  Column(
                    children: [
                      loadingPinned == null
                          ? Container()
                          : pinnedCategory.length == 0
                              ? Container()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: pinnedCategory.length,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryItemDetails(
                                                      id: pinnedCategory[i].id,
                                                      categoryName:
                                                          widget.categoryName,
                                                    )));
                                      },
                                      child: CategoryCard(
                                        name: pinnedCategory[i].name,
                                        pinned: true,
                                        category: pinnedCategory[i],
                                        img: pinnedCategory[i].logo,
                                        rate: pinnedCategory[i].stars,
                                      ),
                                    );
                                  }),
                      loadingPinned == null
                          ? Container()
                          : pinnedCategory.length == 0
                              ? Container()
                              : Divider(
                                  thickness: 3,
                                ),
                      loading == null
                          ? Container()
//                          : Provider.of<MapHelper>(context, listen: false)
//                                      .position ==
//                                  null
//                              ? Container(
//                                  height: MediaQuery.of(context).size.width,
//                                  child: Center(
//                                    child: Text(localization
//                                        .text("Location must be specified")),
//                                  ),
//                                )
                              : category.length == 0
                                  ? Container(
                                      height: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(localization.text(
                                            "There are no stores in your domain")),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: category.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryItemDetails(
                                                          id: category[i].id,
                                                          categoryName: widget
                                                              .categoryName,
                                                        )));
                                          },
                                          child: CategoryCard(
                                            name: category[i].name,
                                            category: category[i],
                                            img: category[i].logo,
                                            rate: category[i].stars,
                                          ),
                                        );
                                      }),
                    ],
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

  chooseFiltrationMethod(BuildContext context) {
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
//                        txt,
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
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

//                      _getShared();

                      Provider.of<MapHelper>(context, listen: false)
                          .getLocation()
                          .then((value) async {
                        Provider.of<MapHelper>(context, listen: false)
                                    .position ==
                                null
                            ? LoadingDialog(_scafold, context).showNotification(
                                localization.text("Location must be specified"))
                            : getDataByLat(
//                                Provider.of<MapHelper>(context, listen: false)
//                                    .position
//                                    .latitude
//                                    .toString(),
//                                Provider.of<MapHelper>(context, listen: false)
//                                    .position
//                                    .longitude
//                                    .toString()
                        );
                      });
                    },
                    text: localization.text("nearest"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      getAllStoresOfCategory().then((value) {
                        setState(() {
                          print("111111111111111111111");
                          category.sort((m1, m2) {
                            var r = m1.stars == null || m2.stars == null
                                ? m1.id.compareTo(m2.id)
                                : m1.stars.compareTo(m2.stars);
//                            if (r != 0)
                            return r;
////                            return m1.stars == null || m2.stars == null
////                                ? m1.id.compareTo(m2.id)
////                                : m1.stars.compareTo(m2.stars);
                          });
                          category = category.reversed.toList();

//                          print("222222222222222222222");
//                          category.reversed.toList() ;
//                          print("111111111111111111111");
//                          category.sort((a, b) => a.stars.compareTo(b.stars));
//                          category =  category.reversed.toList() ;
                        });
                      });
                    },
                    text: localization.text("higher rate"),
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
