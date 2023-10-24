import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
final FirebaseApp secondaryApp = Firebase.app('OnDaMenu-POS');
final FirebaseFirestore firestore2 = FirebaseFirestore.instanceFor(app: secondaryApp);
*/

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  FirebaseAuth _firebaseAuthPOS = FirebaseAuth.instanceFor(app: secondaryApp);
  late String _firebaseTimeStamp;

  final lngth = Firebase.apps.length;


  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
    // return _firebaseAuthPOS.currentUser!.uid;
  }

  /*String getPosID() {
    // return _firebaseAuth.currentUser!.uid;
    return _firebaseAuthPOS.currentUser!.uid;
  }*/

  String setDayAndTime() {
    return _firebaseTimeStamp = (DateTime.now()).toString();
  }
  // final FirebaseFirestore _firestore2 = FirebaseFirestore.instanceFor(Firebase.app("OnDaMenu-POS"));

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference customerSrvcsRef =
      FirebaseFirestore.instance.collection("Customer-Srvcs");

  final CollectionReference servicesRef =
      FirebaseFirestore.instance.collection("Services");

  final CollectionReference sellersRef =
      FirebaseFirestore.instance.collection("Retailers");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");

/*  final CollectionReference usersRefPOS =
      firestore2.collection("Merchants");

  final CollectionReference servicesRefPOS =
      firestore2.collection("Services");*/


}