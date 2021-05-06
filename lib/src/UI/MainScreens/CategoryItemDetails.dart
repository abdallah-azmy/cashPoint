import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CategoryItemDetails extends StatefulWidget {
  final scaffold;
  final id;
  CategoryItemDetails({
    this.scaffold,
    this.id,
  });
  @override
  _CategoryItemDetailsState createState() => _CategoryItemDetailsState();
}

class _CategoryItemDetailsState extends State<CategoryItemDetails> {
  String phone;

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var slider = [];

//  double rating = 4.0;

//  var categoryItemDetails = [
//    {
//      "comment": "من افضل المطاعم التي تعاملت معها في كل شيء شكرا جزيلا لكم",
//      "userName": "احمد توفيق",
//      "time": "10:30 AM",
//      "img":
//          "https://www.deputy.com/uploads/2018/08/Screen-Shot-2018-08-08-at-12.19.36-PM.png",
//    },
//    {
//      "comment": "من افضل المطاعم التي تعاملت معها",
//      "userName": "احمد توفيق",
//      "time": "10:30 AM",
//      "img":
//          "https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_103367090-e1571110045215.jpg?auto=format&q=60&fit=max&w=930",
//    },
//    {
//      "comment":
//          "من افضل المطاعم التي تعاملت معها من افضل المطاعم التي تعاملت معها من افضل المطاعم التي تعاملت معها من افضل المطاعم التي تعاملت معها من افضل المطاعم التي تعاملت معها",
//      "userName": "احمد توفيق",
//      "time": "10:30 AM",
//      "img": "https://penji.co/wp-content/uploads/2020/10/Dave-BURGITOS.jpg",
//    },
//
//  ];

  SharedPreferences _prefs;
  var apiToken;
  var details;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });
    getData();
    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_scafold, context).showLoadingDilaog();
    print("api_token >>>>> $apiToken");
    await ApiProvider(_scafold, context)
        .getStoreDetails(store_id: widget.id)
        .then((value) async {
      if (value.code == 200) {
        print("correct connection");
        setState(() {
          details = value.data;
          print("${double.parse('${details.stars}')}");
          slider = value.data.sliders;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          backgroundColor: Colors.white,
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
                              details == null
                                  ? ""
                                  : details.name == null
                                  ? ""
                                  : "${details.name}",
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
//                  color: MyColors.blue,
                    child:slider == null ? Center(
                      child: Container(child: Text("لا يوجد صور"),),
                    ): (slider.length == 0 )
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
                                    onTap: () {},
                                    child:
                                    Container( height: 200.0,
                                        width: MediaQuery.of(context).size.width -
                                            30,child: CustomProductImage(image: slider[index].image ,))
//                                    CachedNetworkImage(
//                                      height: 200.0,
//                                      width: MediaQuery.of(context).size.width -
//                                          30,
//                                      fit: BoxFit.fill,
//                                      imageUrl: slider[index].image == null
//                                          ? " "
//                                          : "${slider[index].image}",
//                                      imageBuilder: (context, imageProvider) =>
//                                          Container(
//                                        decoration: BoxDecoration(
//                                          borderRadius:
//                                              BorderRadius.circular(5),
//                                          image: DecorationImage(
//                                              image: imageProvider,
//                                              fit: BoxFit.cover),
//                                        ),
//                                      ),
//                                      placeholder: (context, url) =>
//                                          new Container(
//                                        height: 30,
//                                        width: 35,
////                                      color: MyColors.grey,
//                                        child: Center(
//                                            child: CircularProgressIndicator()),
//                                      ),
//                                      placeholderFadeInDuration:
//                                          Duration(milliseconds: 500),
//                                      errorWidget: (context, url, error) =>
//                                          new Container(
//                                        height: 200.0,
//                                        width:
//                                            MediaQuery.of(context).size.width -
//                                                30,
//                                        color: MyColors.grey,
//                                      ),
//                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${details == null ? "" : details.stars == null ? "" : "${details.stars.length > 3 ? details.stars.substring(0, 3) : details.stars}"} Star Ratings",
                              style: MyColors.styleNormalOrange0,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              localization.text("About the store"),
                              style: MyColors.styleBold1,
                            ),
                            details == null
                                ? Container()
                                : SmoothStarRating(
                                    allowHalfRating: false,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: double.parse('${details.stars}'),
                                    size: 20.0,
                                    isReadOnly: true,
                                    color: MyColors.orange,
                                    borderColor: MyColors.orange,
                                    spacing: 2.0)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(details == null
                            ? ""
                            : details.description == null
                                ? ""
                                : "${details.description}"),
                        SizedBox(
                          height: 20,
                        ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: [
//                          Text(
//                            localization.text("comments"),
//                            style: MyColors.styleBold1,
//                          ),
//                        ],
//                      ),
                      ],
                    ),
                  ),
//                SizedBox(
//                  height: 10,
//                ),
//                Container(
//                  height: 100,
//                  child: ListView.builder(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      itemCount: categoryItemDetails.length,
//                      itemBuilder: (context, i) {
//                        return InkWell(
//                          onTap: () {
////                            Navigator.push(
////                                context,
////                                MaterialPageRoute(
////                                    builder: (context) => CategoryItemDetails()));
//                          },
//                          child: CommentCard(
//                            comment: categoryItemDetails[i]["comment"],
//                            img: categoryItemDetails[i]["img"],
//                            time: categoryItemDetails[i]["time"],
//                            userName: categoryItemDetails[i]["userName"],
//                          ),
//                        );
//                      }),
//                ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
