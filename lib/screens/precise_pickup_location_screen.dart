import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:rydex/info_handler/app_info.dart';
import 'package:rydex/models/directions.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';

class PrecisePickupLocationScreen extends StatefulWidget {
  const PrecisePickupLocationScreen({super.key});

  @override
  State<PrecisePickupLocationScreen> createState() => _PrecisePickupLocationScreenState();
}

class _PrecisePickupLocationScreenState extends State<PrecisePickupLocationScreen> {

  LatLng? pick_Location;
  loc.Location location = loc.Location();
  String? _address;

   final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(8.4945477, 4.5910293), zoom: 15);

  GlobalKey<ScaffoldState> _ScaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 300;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geolocator = Geolocator();

  LocationPermission? _locationPermission;

  double bottomPaddingOfMap = 0;


  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);

    newGoogleapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCordinates(
            userCurrentPosition!, context);
    print("address: $humanReadableAddress");
  }

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: pick_Location!.latitude,
          longitude: pick_Location!.longitude,
          googleMapApiKey: apiKey);
      setState(() {
        Directions userPickupddress = Directions();
        userPickupddress.locationLatitude = pick_Location!.latitude;
        userPickupddress.locationLongitude = pick_Location!.longitude;
        userPickupddress.locationName = data.address;
        Provider.of<AppInfo>(context).updatePickupLocationAddress(userPickupddress);

        // _address = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Stack(
      children: [
        
        GoogleMap(
          mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleapController = controller;

                setState(() {
                  bottomPaddingOfMap = 100;
                });
                locateUserPosition();
              },
              onCameraMove: (CameraPosition? position) {
                if (pick_Location != position!.target) {
                  setState(() {
                    pick_Location = position.target;
                  });
                }
              },
              onCameraIdle: () {
                getAddressFromLatLng();
              },
        ),
        Positioned(
              top: 30,
              right: 260,
              left: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10
                    ),
                    child: Center(child: Icon(Icons.chevron_left)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 20,
              left: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white),
                child: Center(
                  child: ReuseableText(
                    title:
                        Provider.of<AppInfo>(context).userPickupLocation != null
                            ? (Provider.of<AppInfo>(context)
                                        .userPickupLocation!
                                        .locationName!)
                                    .substring(0, 50) +
                                '...'
                            : "set your pick up location",
                    style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ),
            ),
        Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: bottomPaddingOfMap),
                child: Image.asset(
                  "assets/images/pickup.png",
                  scale: 15,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: darkTheme ? Colors.amber.shade400 : Colors.lightBlue,
                  child: Center(
                    child: ReuseableText(title: "Set current location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkTheme ? Colors.black : Colors.white)),

                  ),

                ),
              ),
            )

            
      ],
    );
  }
}