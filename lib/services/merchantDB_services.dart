import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseApp secondaryApp = Firebase.app('OnDaMenu-POS');
final FirebaseAuth _firebaseAuthPOS = FirebaseAuth.instanceFor(app: secondaryApp);
final FirebaseFirestore _firestoreDB = FirebaseFirestore.instanceFor(app: secondaryApp);

// Sign in with email and password
Future<UserCredential?> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('merchant authentication completed');
    return userCredential;
  } on FirebaseAuthException catch (e) {
    print('Failed with error code: ${e.code}');
    print(e.message);
    return null;
  }
}

Future<void> getSecondaryDatabaseProducts() async {
  try {
    // await FirebaseFirestore.instanceFor(app: Firebase.app('secondary'))
    await _firestoreDB
        .collection('Products')
        .get()
        .then((value) => value.docs
        .forEach((element) {
          var docRef = element.id;
          print('products are: $docRef');
    }));
    print('Data written to secondary database successfully.');
  } catch (e) {
    print('Error writing to secondary database: $e');
  }    
}

Future<void> writeToSecondaryDatabase(String data) async {
  try {
    await _firestoreDB
    // await FirebaseFirestore.instanceFor(app: Firebase.app('secondary'))
        .collection('Products')
        .doc('your_document')
        .set({'field': data});
    print('Data written to secondary database successfully.');
  } catch (e) {
    print('Error writing to secondary database: $e');
  }
}

Future<void> getMerchantID() async {
  signInWithEmailAndPassword("ntlygens@yahoo.com", "Pa\$\$w@rd1");
  getSecondaryDatabaseProducts();
  /*await _firestoreDB
        .collection('Products')
        .get()
        .then((value) => value.docs
        .forEach((element) {
          // var docRef = _firebaseServices.servicesRef
          //   .doc(element.id).snapshots();
          var docRef = element['name'];
          print("$docRef seller retrieved");


        }));
*/
  // return;


}
class MerchantDBServices {


  /*String getUserID() {
    return _firebaseAuth.currentUser!.uid;
    // return _firebaseAuthPOS.currentUser!.uid;
  }*/
  
  final CollectionReference menuRef = 
      _firestoreDB.collection("Products");

}