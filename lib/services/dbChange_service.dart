import 'package:firebase_auth/firebase_auth.dart';

class DbChangeService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _firebaseTimeStamp;

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  String setDayAndTime() {
    return _firebaseTimeStamp = (DateTime.now()).toString();
  }

// ** // Dummny Btn to change DB data //
/*child: IconButton(
                                          onPressed: () {
                                            _firebaseServices.productsRef
                                                .get()
                                                .then(
                                                  (value) => value.docs.forEach(
                                                    (element) {
                                                  var docRef = _firebaseServices.productsRef
                                                      .doc(element.id);

                                                  docRef.update({'isSelected': false});
                                                },
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.done),
                                        ),*/
// ** //

}