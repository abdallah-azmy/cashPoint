import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/helper/map_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart' as mapLaunch;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:cashpoint/src/UI/MainWidgets/mapPositionFromLatLon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/painting.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryItemDetails extends StatefulWidget {
  final scaffold;
  final id;
  final categoryName;
  CategoryItemDetails({
    this.scaffold,
    this.id,
    this.categoryName,
  });
  @override
  _CategoryItemDetailsState createState() => _CategoryItemDetailsState();
}

class _CategoryItemDetailsState extends State<CategoryItemDetails> {
  String phone;

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var slider = [];
  var countryController;


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


  Future<double> getDistance(lat, long) async {
    print("@@@@@@@@@@@@@@@@${Provider.of<MapHelper>(context, listen: false).position.latitude}");
    print("${Provider.of<MapHelper>(context, listen: false).position.longitude}");
    print("${lat}");
    print("${long}");

    double _distanceInMeters = Geolocator.distanceBetween(
      Provider.of<MapHelper>(context, listen: false).position.latitude,
      Provider.of<MapHelper>(context, listen: false).position.longitude,
      lat,
      long,
    );
    print("${_distanceInMeters}");
//    print("111111 $_distanceInMeters");
    return _distanceInMeters * .001;
  }

  callPhone(num) {
    String phoneNumber = "tel:" + num;
    launch(phoneNumber);
  }

  getNameOfLocation(lat, long) async {
    final coordinates = new Coordinates(double.parse(lat), double.parse(long));
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    setState(() {
      countryController = first.addressLine;
    });
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
        getNameOfLocation(details.latitude,details.longitude);
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }

  _launchMap(lat,long) async {
    if (await mapLaunch.MapLauncher.isMapAvailable(mapLaunch.MapType.google)) {
      await mapLaunch.MapLauncher.launchMap(
        mapType: mapLaunch.MapType.google,
        coords:mapLaunch.Coords(lat, long),
        title: "name",
        description: "disc",
      );
    } else {
      if (await mapLaunch.MapLauncher.isMapAvailable(mapLaunch.MapType.apple)) {
        await mapLaunch.MapLauncher.launchMap(
          mapType: mapLaunch.MapType.apple,
          coords: mapLaunch.Coords(lat, long),
          title: "name",
          description: "description",
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MapHelper>(context, listen: false).position == null
        ?  Provider.of<MapHelper>(context, listen: false)
        .getLocation() : print("there is position") ;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [


                                    Text("${widget.categoryName}",style: MyColors.styleBold2,),

                                    SizedBox(width: 5,),
                                    SizedBox(height: 20,child: VerticalDivider(thickness: 3,)),
                                    SizedBox(width: 5,),
                                    details == null
                                        ? Container() : InkWell(onTap: (){
                                      callPhone("${details.phone}");
                                    },child: Icon(Icons.phone,size: 24,color: Colors.blue[900],)),

                                  ],
                                ),

                                SizedBox(height: 10,),


                              ],
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


//                        details == null ? Container() : details.latitude == null ? Container() :  PositionFromLatLon(lat: double.parse(details.latitude),long: double.parse(details.longitude),scaffoldKey: _scafold,),


                        details == null ? Container() :   Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(localization.text("to go to the store"),style: MyColors.styleBold0,),
                            SizedBox(width: 5,),
                            InkWell(onTap: (){
                            _launchMap(double.parse("${details.latitude}"),double.parse("${details.longitude}"));
                      },child: Icon(Icons.location_on,size: 25,)),
                          ],
                        ),


                        Row(
//                            mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(child: Text(localization.text("The distance to the facility"),style: MyColors.styleBold0,)),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                Text(
                                  "KM",
                                  style: MyColors.styleBold1Orange,
                                ),
                                SizedBox(
                                  width: 4,
                                ),

                                details == null ? Container() :    Provider.of<MapHelper>(context, listen: false).position == null ? Container():      FutureBuilder<double>(
                                  future: getDistance(
                                      double.parse(
                                          '${details.latitude}'),
                                      double.parse(
                                          '${details.longitude}')),
                                  initialData: 0.0,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return
//                        Text("${snapshot.data}");
                                        Text(
                                          "${snapshot.data.toStringAsFixed(2)}",
                                          style: MyColors.styleBold0,
                                        );
                                    } else {
                                      return Container(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 18,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              localization.text("About the store"),
                              style: MyColors.styleBold1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
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
