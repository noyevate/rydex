import 'package:firebase_auth/firebase_auth.dart';
import 'package:rydex/models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;

UserModel? UserModelCurrentInfo;

String UserDropOffAddress = "";