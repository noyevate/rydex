import 'package:firebase_database/firebase_database.dart';
import 'package:rydex/assistants/request_assistant.dart';
import 'package:rydex/global/global.dart';
import 'package:rydex/models/directions.dart';
import 'package:rydex/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rydex/core/space_exs.dart';

class AssistantMethods {
  static void readCurrentOnlineUserInfo () {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("trippo-users").child(currentUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null ) {
        UserModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<String> searchAddressForGeographicCordinates(Position position, context ) async{

    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey";
    String humanRedableAddress = '';

    var requestResponse = await RequestAssistant.recieveRequest(apiUrl);
    if(requestResponse != "no response") {
      humanRedableAddress = requestResponse['results'][0]['fomatted_address'];

      Directions userPickupddress = Directions();
      userPickupddress.locationLatitude = position.latitude;
      userPickupddress.locationLongitude = position.longitude;
      userPickupddress.locationName = humanRedableAddress;
      
    }

    return humanRedableAddress;
  }
}