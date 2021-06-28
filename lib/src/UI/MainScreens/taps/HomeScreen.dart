import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';
import 'package:cashpoint/src/UI/MainScreens/CategoryItemDetails.dart';
import 'package:cashpoint/src/UI/MainScreens/taps/MyHomeForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:cashpoint/src/UI/MainWidgets/Home_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Icon.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:cashpoint/src/helper/map_helper.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart' as intl;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../MainWidgets/Special_Text_Field_search.dart';
import '../CategoryScreen.dart';

class HomeScreen extends StatefulWidget {
  final scaffold;
  final bottomNavigationKey;
  final openDrawer;
  HomeScreen({this.scaffold, this.openDrawer, this.bottomNavigationKey});
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  SharedPreferences _prefs;
  var apiToken;
  String restaurantSearch;
  var details;
  var loading;
  var loadingWelcomeMessage;
  bool noDataFound = false;
  var slider = [];
  var homeCategories = [];
  var filteredCategories = [];
  var name;

  String aaa;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      name = _prefs.getString("name");
      getData();
    });

    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    print("api_token >>>>> $apiToken");
    await ApiProvider(_key, context).getGeneralSlider().then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          slider = value.data;
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

//        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });

    await ApiProvider(_key, context)
        .getGeneralData(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
        print("<<<<<<<<<<<<<<<<<<<<<<1>>>>>>>>>>>>>>>>>>");
        setState(() {
          details = value.data;
          loadingWelcomeMessage = false;
        });
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        setState(() {
          loadingWelcomeMessage = false;
        });
//        Navigator.pop(context);
//        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });

    await ApiProvider(_key, context)
        .getCategories(networkError: false)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          homeCategories = value.data;
          filteredCategories = homeCategories;
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        setState(() {
          loading = false;
        });
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _setSearchFilter(val) {
    if (val == null) {
      print("no search text");
    } else {
      setState(() {
        filteredCategories = homeCategories
            .where((x) => x.name.toLowerCase().contains("${val.toLowerCase()}"))
            .toList();
      });
    }

    if (filteredCategories.length == 0) {
      noDataFound = true;
    } else {
      noDataFound = false;
    }
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
          body: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      hintColor: Colors.transparent,
                    ),
                    child: SpecialTextFieldSearch(
                      onChange: (value) {
                        setState(() {
                          restaurantSearch = value;
                        });

                        if (value == null || value == "") {
                          setState(() {
                            filteredCategories = homeCategories;
                            noDataFound = false;
                          });
                        }
                      },
                      icon: restaurantSearch == null || restaurantSearch == ""
                          ? Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Icon(
                                Icons.search,
                                color: Colors.black54,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: InkWell(
                                onTap: () {
                                  _setSearchFilter(restaurantSearch);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    localization.text("search"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                      hint: localization.text("search_key"),
                      filledColor: Color(0xffefefef),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
//                  color: MyColors.blue,
                  child: slider.length == 0
                      ? Center(
                          child: Container(),
                        )
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
//                        aspectRatio: MediaQuery.of(context).size.width /
//                            MediaQuery.of(context).size.height,
                            viewportFraction: 0.9,
                            aspectRatio: 2.0,
//                    enlargeCenterPage: true,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 2500),
                            autoPlayCurve: Curves.easeInOutBack,
                            pauseAutoPlayOnTouch: true,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          items: List.generate(slider.length, (index) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                    onTap: () {

                                      if(slider[index].adminId == 0){

                                        slider[index].typeOfAdvertisement == 0 ?

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryItemDetails(
                                                      id: slider[index]
                                                          .userId,
                                                    )))

                                            :  _launchURL(slider[index].link);




                                      }else {


                                        if (slider[index].link != "") {
                                          _launchURL(slider[index].link);
                                        } else  {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryItemDetails(
                                                        id: slider[index]
                                                            .userId,
                                                      )));
                                        }

                                      }









                                    },
                                    child: Container(
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        child: CustomProductImage(
                                          image: slider[index].image,
                                        ))
//                                  CachedNetworkImage(
//                                    height: 200.0,
//                                    width:
//                                        MediaQuery.of(context).size.width - 30,
//                                    fit: BoxFit.fill,
//                                    imageUrl: slider[index] == null
//                                        ? " "
//                                        : "${slider[index].image}",
//                                    imageBuilder: (context, imageProvider) =>
//                                        Container(
//                                      decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(5),
//                                        image: DecorationImage(
//                                            image: imageProvider,
//                                            fit: BoxFit.cover),
//                                      ),
//                                    ),
//                                    placeholder: (context, url) =>
//                                        new Container(
//                                      height: 30,
//                                      width: 35,
////                                      color: MyColors.grey,
//                                      child: Center(
//                                          child: CircularProgressIndicator()),
//                                    ),
//                                    placeholderFadeInDuration:
//                                        Duration(milliseconds: 500),
//                                    errorWidget: (context, url, error) =>
//                                        new Container(
//                                      height: 200.0,
//                                      width: MediaQuery.of(context).size.width -
//                                          30,
//                                      color: MyColors.grey,
//                                    ),
//                                  ),
                                    );
                              },
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                loadingWelcomeMessage == null
                    ? Container()
                    : Text(
                        details == null
                            ? ""
                            : details.minText == null
                                ?  localization.currentLanguage.toString() == "en" ? "welcome ${name == null ? "" : "$name"}" : "يا هلا فيك ${name == null ? "نورتنا" : "$name"}"
                                : "${details.minText}",
                        textAlign: TextAlign.center,
                        style: MyColors.styleBold1,
                      ),
                loadingWelcomeMessage == null
                    ? Container()
                    : Text(
                        details == null
                            ? ""
                            : details.subMinText == null
                                ? localization.text("Where would you like to collect your points today ?")
                                : "${details.subMinText} ${name == null ? "" : "$name"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            // fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 11,
                    left: 11,
                  ),
                  child: Container(
//                        height: MediaQuery.of(context).size.height * .7,
                    width: MediaQuery.of(context).size.width,
                    child: loading == null
                        ? Container()
                        : noDataFound == true
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Text(localization.text("no search results")),
                                ),
                              )
                            : filteredCategories.length == 0
                                ? Container(
                                    height: 200,
                                    child: Center(
                                        child: Text(localization
                                            .text("no services in your area"))))
                                : GridView.count(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: 36 / 36,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    children: List.generate(
                                        filteredCategories.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryScreen(
                                                          id:
                                                              filteredCategories[
                                                                      index]
                                                                  .id,
                                                          categoryName:
                                                              filteredCategories[
                                                                      index]
                                                                  .name,
                                                          img:
                                                              filteredCategories[
                                                                      index]
                                                                  .image,
                                                          homeCategories:
                                                              homeCategories)));
                                        },
                                        child: HomeCard(
                                          id: filteredCategories[index].id,
                                          img: filteredCategories[index].image,
                                          category:
                                              filteredCategories[index].name,
                                        ),
                                      );
                                    }),
                                  ),
                  ),
                ),
                SizedBox(
                  height: 85,
                )
              ],
            ),
          )),
    );
  }
}
