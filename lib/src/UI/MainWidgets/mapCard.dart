//import 'package:ntaqat/src/MyColors.dart';
//import 'package:ntaqat/src/firebaseNotification/appLocalization.dart';
//import 'package:ntaqat/src/helper/map_helper.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:location/location.dart' as locat;
//
//import 'Special_Button.dart';
//import 'customBtn.dart';
//import 'mapFabs.dart';
//
//class MapCard extends StatefulWidget {
//  final ValueChanged<Position> onChange;
//  final picked;
//  final text;
//  final Function onTap;
//  final Function onTextChange;
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final bool withAppBar;
//
//  const MapCard(
//      {Key key,
//      this.onChange,
//      this.onTap,
//      this.text,
//      this.picked,
//      this.onTextChange,
//      this.scaffoldKey,
//      this.withAppBar})
//      : super(key: key);
//
//  @override
//  _MapCardState createState() => _MapCardState();
//}
//
//class _MapCardState extends State<MapCard> {
//  Position _startPosition;
//  GoogleMapController _mapController;
//  ScaffoldFeatureController _bottomSheet;
//
//  _showBottomSheet(Position position, MapType mapType) {
//    _bottomSheet = widget.scaffoldKey.currentState.showBottomSheet((_) {
//      return Container(
//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height - 100,
//        child: ListView(
//          shrinkWrap: true,
//          children: <Widget>[
//            Visibility(
//              visible: widget.withAppBar == null,
//              child: InkWell(
//                onTap: () => Navigator.pop(context),
//                child: Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 60,
//                  color: Theme.of(context).primaryColor,
//                  padding: EdgeInsets.only(left: 10, right: 20),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      InkWell(
//                          onTap: () => Navigator.pop(context),
//                          child:
//                              Icon(Icons.close, size: 28, color: Colors.white)),
//                      Text(localization.text("Location of receipt"),
//                          style: TextStyle(color: Colors.white, fontSize: 17))
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              height: widget.withAppBar == null
//                  ? MediaQuery.of(context).size.height - 180
//                  : MediaQuery.of(context).size.height - 100,
//              width: MediaQuery.of(context).size.width,
//              child:
////              Provider.of<MapHelper>(context, listen: false).position ==
////                      null
////                  ? Center(
////                      child: SpinKitThreeBounce(
////                        color: Theme.of(context).primaryColor,
////                        size: 25,
////                      ),
////                    )
////                  :
//              Stack(
//                      children: <Widget>[
//                        GoogleMap(
//                          onMapCreated: _onMapCreated,
//                          mapType: _currentMapType,
//                          initialCameraPosition: CameraPosition(
//                            target: LatLng(
//                                Provider.of<MapHelper>(context, listen: false)
//                                            .position ==
//                                        null
//                                    ? 26.399250
//                                    : Provider.of<MapHelper>(context,
//                                            listen: false)
//                                        .position
//                                        .latitude,
//                                Provider.of<MapHelper>(context, listen: false)
//                                            .position ==
//                                        null
//                                    ? 49.984360
//                                    : Provider.of<MapHelper>(context,
//                                            listen: false)
//                                        .position
//                                        .longitude),
//                            zoom: 14.0,
//                          ),
//                          onCameraMove: (camera) {
//                            widget.onChange(Position(
//                                latitude: camera.target.latitude,
//                                longitude: camera.target.longitude));
//                          },
//                          gestureRecognizers:
//                              <Factory<OneSequenceGestureRecognizer>>[
//                            new Factory<OneSequenceGestureRecognizer>(
//                              () => new EagerGestureRecognizer(),
//                            ),
//                          ].toSet(),
//                        ),
//                        Center(
//                            child: Image.asset('assets/homeAdress.png',
//                                width: 40)),
//                        Positioned(
//                          right: 15,
//                          left: 15,
//                          bottom: 15,
//                          child: ListView(
//                            shrinkWrap: true,
//                            physics: NeverScrollableScrollPhysics(),
//                            children: <Widget>[
////                              Container(
////                                color: Colors.white,
////                                padding: EdgeInsets.all(10),
////                                child: ListView(
////                                  shrinkWrap: true,
////                                  physics: NeverScrollableScrollPhysics(),
////                                  children: <Widget>[
//////                                    Row(
//////                                      mainAxisAlignment:
//////                                          MainAxisAlignment.start,
//////                                      children: <Widget>[
//////                                        Image.asset('assets/homeAdress.png',
//////                                            width: 30),
//////                                        SizedBox(width: 10),
//////                                        Text("العنوان",
//////                                            style:
//////                                                TextStyle(color: Colors.grey))
//////                                      ],
//////                                    ),
//////                                    TextField(
//////                                      onChanged: widget.onTextChange,
//////                                      textAlign: TextAlign.right,
//////                                      keyboardType: TextInputType.text,
//////                                      decoration: InputDecoration(
//////                                          hintStyle: TextStyle(
//////                                              fontSize: 15, height: .8),
//////                                          hintText: "العنوان بالتفصيل"),
//////                                    )
////                                  ],
////                                ),
////                              ),
////                              SizedBox(height: 10),
//                              CustomBtn(
//                                color: Theme.of(context).primaryColor,
//                                onTap: widget.onTap,
//                                text: localization.text("save"),
//                                txtColor: Colors.white,
//                              )
//                            ],
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: MapFabs(
//                            myLocationButtonEnabled: true,
//                            layersButtonEnabled: true,
//                            onToggleMapTypePressed: _onToggleMapTypePressed,
//                            onMyLocationPressed: () {
//                              _checkGps();
//                              _getLocation();
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//            ),
//          ],
//        ),
//      );
//    });
//  }
//
//  Geolocator _geoLocator = Geolocator();
//
//  var location = locat.Location();
//  Future _checkGps() async {
//    if (!await location.serviceEnabled()) {
//      location.requestService();
//    } else {}
//  }
//
//  MapType _currentMapType = MapType.normal;
//  MapType map;
//  void _onToggleMapTypePressed() {
//    final MapType nextType =
//        MapType.values[(_currentMapType.index + 1) % MapType.values.length];
//
//    _bottomSheet.setState(() => _currentMapType = nextType);
//  }
//
//  _onMapCreated(GoogleMapController controller) {
//    setState(() {
//      _mapController = controller;
//    });
//  }
//
//  Marker _shopMarker;
//
//  Future<Position> _getLocation() async {
//    // _pref = await SharedPreferences.getInstance();
//
//    var currentLocation;
//    try {
//      currentLocation = await Geolocator.getCurrentPosition(
//          desiredAccuracy: LocationAccuracy.best);
//      print(currentLocation.toString());
//      setState(() {
//        _shopMarker = Marker(
//          markerId: MarkerId('target'),
//          position: LatLng(currentLocation.latitude, currentLocation.longitude),
//          infoWindow: InfoWindow(title: localization.text("location")),
//        );
//
//        _mapController.animateCamera(CameraUpdate.newCameraPosition(
//            CameraPosition(
//                target: LatLng(_shopMarker.position.latitude,
//                    _shopMarker.position.longitude),
//                zoom: 14.0)));
//      });
//    } catch (e) {
//      currentLocation = null;
//    }
//    return currentLocation;
//  }
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: () {
//        Provider.of<MapHelper>(context, listen: false).getLocation();
//        _showBottomSheet(_startPosition, _currentMapType);
//      },
//      child: Container(
//        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
//        decoration: BoxDecoration(
//            color: MyColors.blue, borderRadius: BorderRadius.circular(12)),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 3),
//              child: Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.location_on,
//                    color: widget.picked == null ? Colors.white : Colors.green,
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  Text(
//                    widget.text ?? localization.text("location"),
//                    style: MyColors.styleNormalWhite,
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              decoration: BoxDecoration(
//                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
//              child: Padding(
//                padding:
//                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                child: Text(
//                  localization.text("Select the site"),
//                  style: widget.picked == null
//                      ? MyColors.styleBoldOrange
//                      : MyColors.styleBoldGreen,
//                ),
//              ),
//            ),
//          ],
//        ),
//
////      child: Padding(
////        padding: const EdgeInsets.symmetric(horizontal: 65),
////        child: SpecialButton(
////          onTap: () => _showBottomSheet(_startPosition, _currentMapType),
////          color: Colors.black,
////          textSize: 16,
////          textColor: Colors.white,
////          text: localization.text("get_position"),
////          icon: Icon(
////            Icons.location_on,
////            color: Colors.white,
////            size: 17,
////          ),
////        ),
////      ),
//      ),
//    );
//  }
//}
