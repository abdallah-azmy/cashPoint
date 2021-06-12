import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:cashpoint/src/helper/map_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CategoryCard extends StatefulWidget {
  final double distance;
  final rate;
  final name;
  final pinned;
  final category;
  final img;

  final onTap;
  final id;
  final apiToken;
  final categoryId;
  final scaffold;
  final getData;

  const CategoryCard(
      {Key key,
      this.apiToken,
      this.category,
      this.pinned,
      this.scaffold,
      this.img,
      this.onTap,
      this.name,
      this.categoryId,
      this.distance,
      this.rate,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  deleteNotification() async {
//    Navigator.pop(context);
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .deleteNotification(apiToken: widget.apiToken,notification_id: widget.id)
//        .then((value) async {
//      if (value.code == 200) {
//
//
//        Navigator.pop(context);
//        LoadingDialog(widget.scaffold,context)
//            .showNotification(localization.text("notification_deleted"));
//
//        widget.getData();
//
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        Navigator.pop(context);
//
//        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
//      }
//    });
  }

  Future<double> getDistance(lat, long) async {
    double _distanceInMeters = Geolocator.distanceBetween(
      Provider.of<MapHelper>(context, listen: false).position.latitude,
      Provider.of<MapHelper>(context, listen: false).position.longitude,
      lat,
      long,
    );

    print("111111 $_distanceInMeters");
    return _distanceInMeters;
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: CustomProductImage(
                        image: "${widget.img}",
                      ),
                    ),
//                    CachedNetworkImage(
//                      imageBuilder: (context, provider) {
//                        return Container(
//                            height: 80,
//                            width: 80,
//                            decoration: BoxDecoration(
//                                color: Colors.transparent,
//                                borderRadius: BorderRadius.circular(10),
//                                image: DecorationImage(
//                                    image: provider, fit: BoxFit.fill)));
//                      },
//                      fit: BoxFit.fill,
//                      imageUrl: "${widget.img}",
//                      placeholder: (context, url) => new Container(
//                        height: 80,
//                        width: 80,
//                        color: Colors.transparent,
//                        child: Container(
//                            height: 80,
//                            width: 80,
//                            child: Center(child: CircularProgressIndicator())),
//                      ),
//                      errorWidget: (context, url, error) => new Container(
//                        height: 80,
//                        width: 80,
//                        color: MyColors.grey,
//                      ),
//                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "${widget.name}",
                                  style: MyColors.styleBold2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: MyColors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child:
//                      Row(
//                        children: [
//                          Text(
//                            "Km",
//                            style: MyColors.styleBold0white,
//                          ),
//                          SizedBox(width: 3,),
//                          Text(
//                            "${widget.distance}",
//                            style: MyColors.styleBold0white,
//                          ),
//
//                        ],
//                      ),


                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRated: (v) {},
                                      starCount: 5,
                                      rating: double.parse('${widget.rate}'),
                                      size: 17.0,
                                      isReadOnly: true,
                                      color: Colors.yellow,
                                      borderColor: Colors.white,
                                      spacing: 2.0)
//                                      Row(mainAxisSize: MainAxisSize.min,
//                                    children: [
//                                      Icon(
//                                        Icons.star,
//                                        color: Colors.white,
//                                        size: 18,
//                                      ),
//                                      SizedBox(
//                                        width: 5,
//                                      ),
//                                      Text(
//                                        "${widget.rate.length > 3 ? widget.rate.substring(0, 3) : widget.rate}",
//                                        style: MyColors.styleBold0white,
//                                      ),
//                                    ],
//                                  ),


                                ),
                              ),

                            ],
                          ),
                          Row(
//                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "KM",
                                style: MyColors.styleBold1Orange,
                              ),
                              SizedBox(
                                width: 4,
                              ),

                              FutureBuilder<double>(
                                future: getDistance(
                                    double.parse(
                                        '${widget.category.latitude}'),
                                    double.parse(
                                        '${widget.category.longitude}')),
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
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),





                       widget.pinned == null ? Container() :   Row(
//                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.check_circle,color: Colors.green[900],size: 17,)
                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}




class CustomWidget extends StatefulWidget {
  CustomWidget({Key key}) : super(key: key);
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  double _currentSliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFACFFBC),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
