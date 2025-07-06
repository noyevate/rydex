import 'package:firebase_database/firebase_database.dart';
import 'package:rydex/global/global.dart';
import 'package:rydex/models/user_model.dart';

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
}