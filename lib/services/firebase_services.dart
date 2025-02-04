import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _firebaseTimeStamp;
  late FirebaseApp odmPOS = Firebase.app("ondamenuPOS");
  late FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: odmPOS);


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





  late CollectionReference odmPOS_ProdRef =
      // FirebaseFirestore.instanceFor(app: odmPOS).collection("Products");
      firestore.collection("Products");

  late CollectionReference odmPOS_ProdChstRef =
      // FirebaseFirestore.instanceFor(app: odmPOS).collection("Products");
      firestore.collection("Product-Chest");


}