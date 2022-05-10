import 'package:demo/resturantPractice/resturanpage.dart';
import 'package:demo/widget/inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cartprovider with ChangeNotifier {
  int cartvalue = 0;
  bool isloading = false;
  bool animation = false;
  bool iscart = false;
  var address;
  void cartbadge() {
    cartvalue++;
    notifyListeners();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print("complete details  :  $placemarks");
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print("complete address : " + Address);
    locate = '${place.subLocality}';
    print("Area: " + locate);
  }

  String Address = 'search';
  String locate = '';
  Future currentlocation(BuildContext context) async {
    Position position = await _getGeoLocationPosition();
    final _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final latitude = prefs.setDouble('latitude', position.latitude);
    final longitude = prefs.setDouble('longtitude', position.longitude);
    final latlong = prefs.getDouble('longtitude');

    GetAddressFromLatLong(position);
    // print("latitude :  $latitude");
    // print("longitude :  $longitude");
    // print("aaaaaaaaaaaaaadddd :  $latlong");

    // menu.menuitems();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];

    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print('latest address: ${place.street}');
    if (latitude.toString().isNotEmpty && latitude.toString().isNotEmpty) {
      print("latitude :  $latitude");
      print("longitude :  $longitude");
      print("aaaaaaaaaaaaaadddd :  $latlong");
      return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InheritedDataProvider(
                  child: resturantpage(),
                  data: Address,
                )),
      );
    } else {
      CircularProgressIndicator();
    }
  }
}
