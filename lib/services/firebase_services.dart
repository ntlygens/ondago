import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late String _firebaseTimeStamp;

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  String setDayAndTime() {
    return _firebaseTimeStamp = (DateTime.now()).toString();
  }

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

  final Query<Map<String, dynamic>> foodTypesGroupRef =
      FirebaseFirestore.instance.collectionGroup('foodType');

}