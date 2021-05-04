
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as lo;

class MapHelper with ChangeNotifier {
  getLocationPermission() async {
    final lo.Location location = lo.Location();
    bool _serviceEnabled;
    lo.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == lo.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != lo.PermissionStatus.granted) {
        return;
      }
    }
  }

  Position position;
  SharedPreferences _preferences;
  MapType mapType = MapType.normal;
  Future<Position> getLocation() async {
    print("888888888888888888888");
//    getLocationPermission();
    Geolocator _geoLocator = Geolocator();
    var currentLocation;
    try {
      _preferences = await SharedPreferences.getInstance();
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      _preferences.setDouble("long", currentLocation.longitude);
      _preferences.setDouble("lat", currentLocation.latitude);
      print("aaaaaaaaaaaaaaaaabbbbbbbbbbbbnnnnn");
      print(currentLocation.toString());
      print("aaaaaaaaaaaaaaaaabbbbbbbbbbbbnnnnn");

      position = currentLocation;
      notifyListeners();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  changeMapType(MapType m) {
    mapType = m;
    notifyListeners();
  }
}
