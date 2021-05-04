//import 'package:map_launcher/map_launcher.dart' as mapLaunch;
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
//
//import 'Special_Button.dart';
//import 'customBtn.dart';
//import 'mapFabs.dart';
//
//class PositionFromLatLon extends StatefulWidget {
//  final ValueChanged<Position> onChange;
//  final  picked ;
//  final  lat ;
//  final  long ;
//  final Function onTap;
//  final Function onTextChange;
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final bool withAppBar;
//
//  const PositionFromLatLon(
//      {Key key,
//        this.onChange,
//        this.lat,
//        this.long,
//        this.onTap,
//        this.picked,
//        this.onTextChange,
//        this.scaffoldKey,
//        this.withAppBar})
//      : super(key: key);
//
//  @override
//  _PositionFromLatLonState createState() => _PositionFromLatLonState();
//}
//
//class _PositionFromLatLonState extends State<PositionFromLatLon> {
//
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
//                          Icon(Icons.close, size: 28, color: Colors.white)),
//                      Text(localization.text("location"),
//                          style: TextStyle(color: Colors.white, fontSize: 17))
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              height: widget.withAppBar == null
//                  ? MediaQuery.of(context).size.height - 150
//                  : MediaQuery.of(context).size.height - 80,
//              width: MediaQuery.of(context).size.width,
//              child:
////              Provider.of<MapHelper>(context, listen: false).position ==
////                  null
////                  ? Center(
////                child: SpinKitThreeBounce(
////                  color: Theme.of(context).primaryColor,
////                  size: 25,
////                ),
////              )
////                  :
//              Stack(
//                children: <Widget>[
//                  GoogleMap(
//                    onMapCreated: _onMapCreated,
//                    mapType: _currentMapType,
//                    initialCameraPosition: CameraPosition(
//                      target: LatLng(
//                          widget.lat,
//                          widget.long),
//                      zoom: 14.0,
//                    ),
////                    onCameraMove: (camera) {
////                      widget.onChange(Position(
////                          latitude: camera.target.latitude,
////                          longitude: camera.target.longitude));
////                    },
//                    gestureRecognizers:
//                    <Factory<OneSequenceGestureRecognizer>>[
//                      new Factory<OneSequenceGestureRecognizer>(
//                            () => new EagerGestureRecognizer(),
//                      ),
//                    ].toSet(),
//                  ),
//                  Center(
//                      child: Image.asset('assets/homeAdress.png',
//                          width: 40)),
//                  Positioned(
//                    right: 15,
//                    left: 15,
//                    bottom: 15,
//                    child:
////                    ListView(
////                      shrinkWrap: true,
////                      physics: NeverScrollableScrollPhysics(),
////                      children: <Widget>[
////                        Container(
////                          color: Colors.white,
////                          padding: EdgeInsets.all(10),
////                          child: ListView(
////                            shrinkWrap: true,
////                            physics: NeverScrollableScrollPhysics(),
////                            children: <Widget>[
////                              Row(
////                                mainAxisAlignment:
////                                MainAxisAlignment.start,
////                                children: <Widget>[
////                                  Image.asset('assets/homeAdress.png',
////                                      width: 30),
////                                  SizedBox(width: 10),
////                                  Text(localization.text("location"),
////                                      style:
////                                      TextStyle(color: Colors.grey))
////                                ],
////                              ),
////                              TextField(
////                                onChanged: widget.onTextChange,
////                                textAlign: TextAlign.right,
////                                keyboardType: TextInputType.text,
////                                decoration: InputDecoration(
////                                    hintStyle: TextStyle(
////                                        fontSize: 15, height: .8),
////                                    hintText:
////                                    localization.text("specific_address")),
////                              )
////                            ],
////                          ),
////                        ),
////                        SizedBox(height: 10),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 43),
//                      child: CustomBtn(
//                        color: Theme.of(context).primaryColor,
//                        onTap: (){
//                          _launchMap(widget.lat , widget.long);
//                        } ,
//                        text: localization.text("open google map"),
//                        txtColor: Colors.white,
//                      ),
//                    ),
////                      ],
//                  ),
////                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: MapFabs(
//                      myLocationButtonEnabled: true,
//                      layersButtonEnabled: true,
//                      onToggleMapTypePressed: _onToggleMapTypePressed,
//                      onMyLocationPressed: () {
//                        _checkGps();
//                        _getLocation();
//                      },
//                    ),
//                  ),
//                ],
//              ),
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
//    MapType.values[(_currentMapType.index + 1) % MapType.values.length];
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
//          infoWindow: InfoWindow(title: "العنوان"),
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
//
//  _launchMap(lat,long) async {
//    if (await mapLaunch.MapLauncher.isMapAvailable(mapLaunch.MapType.google)) {
//      await mapLaunch.MapLauncher.launchMap(
//        mapType: mapLaunch.MapType.google,
//        coords:mapLaunch.Coords(lat, long),
//        title: "name",
//        description: "disc",
//      );
//    } else {
//      if (await mapLaunch.MapLauncher.isMapAvailable(mapLaunch.MapType.apple)) {
//        await mapLaunch.MapLauncher.launchMap(
//          mapType: mapLaunch.MapType.apple,
//          coords: mapLaunch.Coords(lat, long),
//          title: "name",
//          description: "description",
//        );
//      }
//    }
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
//      onTap: () => _showBottomSheet(_startPosition, _currentMapType),
//      child:  Padding(
//        padding: const EdgeInsets.all(3.0),
//        child: Container(
//          decoration: BoxDecoration(
//              color: MyColors.blue,
//              borderRadius: BorderRadius.circular(5)),
//          child: Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Center(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    localization.text("location on map"),
//                    style: MyColors.styleNormalWhite1,
//                    textAlign: TextAlign.center,
//                  ),
//                  SizedBox(width: 5,),
//                  Icon(Icons.location_on,size: 20,color: Colors.white,)
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
