import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rydex/assistants/assistant_methods.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LatLng? pick_Location;
  loc.Location location = loc.Location();
  String? _address;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 15);

  // ignore: unused_field
  GlobalKey<ScaffoldState> _ScaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 300;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geolocator = Geolocator();

  LocationPermission? _locationPermission;

  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoordinatedList = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};

  Set<Circle> circlesSet = {};

  String username = '';
  String userEmail = '';

  bool openNavgationDrawer = true;

  bool activeNearbyDriverKeysLoaded = false;

  BitmapDescriptor? activeNearbyIcon;

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

  // Future<void> locateUserPosition() async {
  //   // 1. Check if location services are enabled on the device
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     print('Location services are disabled.');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Location services are disabled. Please enable them.')),
  //     );
  //     // Optionally, you might want to open location settings:
  //     // await Geolocator.openLocationSettings();
  //     return; // Stop execution if services are disabled
  //   }

  //   // 2. Check current permission status
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     // Permissions are denied, request them.
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are still denied after requesting.
  //       print('Location permissions are denied (after request).');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Location permission denied. Please grant permission in app settings.')),
  //       );
  //       return; // Stop execution if permissions are denied
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are permanently denied.
  //     print('Location permissions are permanently denied, we cannot request permissions.');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Location permission permanently denied. Please enable it in app settings.'),
  //         action: SnackBarAction(
  //           label: 'Settings',
  //           onPressed: () async {
  //             // await openAppSettings(); // From permission_handler package
  //           },
  //         ),
  //       ),
  //     );
  //     return; // Stop execution if permissions are permanently denied
  //   }

  //   // 3. If permissions are granted (or were already granted)
  //   if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
  //     print('Location permissions granted. Attempting to get position...');
  //     try {
  //       Position cPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );
  //       userCurrentPosition = cPosition; // Assign to your class member

  //       LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
  //       CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 15);

  //       // Ensure newGoogleapController is not null before using it
  //       if (newGoogleapController != null) {
  //         newGoogleapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //       } else {
  //         print('Error: Google Map controller is null.');
  //       }

  //       String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCordinates(userCurrentPosition!, context);
  //       print("address: $humanReadableAddress");

  //     } catch (e) {
  //       print("Error getting location: $e");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error getting location: ${e.toString()}')),
  //       );
  //     }
  //   }
  // }

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: pick_Location!.latitude,
          longitude: pick_Location!.longitude,
          googleMapApiKey: apiKey);
      setState(() {
        _address = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission == LocationPermission.denied) {
        // Permissions are still denied after requesting.
        print('Location permissions are denied (after request).');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Location permission denied. Please grant permission in app settings.')),
        );
        return;
      }
    }
    if (_locationPermission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Location permission permanently denied. Please enable it in app settings.'),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () async {
              // await openAppSettings(); // From permission_handler package
            },
          ),
        ),
      );
      return; // Stop execution if permissions are permanently denied
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              polylines: polylineSet,
              markers: markersSet,
              circles: circlesSet,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleapController = controller;

                setState(() {});
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.asset(
                  "assets/images/pickup.png",
                  scale: 15,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              left: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white),
                child: Center(
                  child: ReuseableText(
                    title: _address ?? "set your pick up location",
                    style: TextStyle(),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
