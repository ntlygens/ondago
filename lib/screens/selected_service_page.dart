import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/screens/retail_client_products_lst.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';
import 'package:ondago/widgets/retail_client_pkg.dart';
import 'package:ondago/widgets/image_swipe.dart';

import '../constants.dart';

class SelectedServicePage extends StatefulWidget {
  final String serviceID;
  final String serviceType;
  final String? headerImg;
  final String? headerName;

  const SelectedServicePage({required this.serviceID, required this.serviceType, this.headerImg, this.headerName});

  @override
  _SelectedServicePageState createState() => _SelectedServicePageState();
}

class _SelectedServicePageState extends State<SelectedServicePage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  final _snackBar = const SnackBar(content: Text("Product added to Cart"));
  late bool _isCustomerSrvc;
  late String? _headerImage;
  late String? _headerName;

  Future _checkSrvcType<String>() async {
    _isCustomerSrvc = false;
    if(widget.serviceType == 'customer') {
      _isCustomerSrvc = true;
    }

    /*return _firebaseServices.servicesRef
        .doc(widget.serviceID)
        .get()
        .then((dSnapshot) => dSnapshot['name']
          .forEach((element){
            // for(DocumentSnapshot ds in dSnapshot)
              print("dSnapshot Data: ${element}");
          })
        );*/

  }

  Future _removeAllServiceProducts() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .get()
        .then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs){
              ds.reference.delete()
          },

          // snapshot.forEach((doc) => {
          //   doc.ref.delete()
          // })
          print(" all products removed!")
        });
  }

  Future _removeThisServiceProduct( prodID ) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .where('prodID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
          // for (DocumentSnapshot ds in snapshot.docs){
          //   ds.reference.delete()
          // },
          print(" current product removed!")
        });
  }

  // async function getUserByEmail(email) {
  //   // Make the initial query
  //   const query = await db.collection('users').where('email', '==', email).get();
  //
  //   if (!query.empty) {
  //     const snapshot = query.docs[0];
  //     const data = snapshot.data();
  //   } else {
  //     // not found
  //   }
  //
  // }

  Future _unselectThisIcon(prodID) async {
    return  _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .where('id', isEqualTo: prodID)
        // .where('prodID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs){
            print("product unselected!")
            // ds.reference.update({'isSelected': false})
          },
          // print("${snapshot.}product unselected!")
        },
    );
  }

  Future _unselectAllIcons(value) async {
    return _firebaseServices.productsRef
        .get()
        .then((value) => value.docs
        .forEach((element) {
          var docRef = _firebaseServices.productsRef
              .doc(element.id);

              docRef.update({'isSelected': false});
          },
        ),
    );
  }

  @override
  void initState() {
    _checkSrvcType();
    _headerImage = widget.headerImg;
    _headerName = widget.headerName;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool alreadySelected = true;

    return Scaffold(
        body: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: _firebaseServices.servicesRef.doc(widget.serviceID).get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("SlctdSrvcPg-SrvcsRef-DataError: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    List docs = snapshot.data!['type'];
                    return ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 14
                            ),
                            child: Text(
                              "${snapshot.data['name']}",
                              style: Constants.boldHeading,
                            ),
                          ),
                          /// Description Row ///
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 24
                            ),

                            child: Text(
                              "${snapshot.data['desc']}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          /// Catagories Label Row ///
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 24,
                                bottom: 0
                            ),
                            child: Text(
                              _isCustomerSrvc ?
                              "${snapshot.data!['name']} Categories" : "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF1E80)
                                )
                            ),
                          ),
                          /// Retail Clients Row ///
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8
                            ),
                            child: RetailClientPkg(
                                  retailClientList: docs,
                                  serviceCategoryName: snapshot.data['name'],
                                  serviceCategoryID: snapshot.data.id,
                                ),
                          ),
                          /// View Btn and Delete Slctd Row ///
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFDCDCDC),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  alignment: Alignment.center,
                                  /// ** // Reset DB Button Below IMPORTANT!!! //
                                  child: IconButton(
                                    onPressed: () {
                                      _unselectAllIcons(snapshot.data!.id);
                                      _removeAllServiceProducts();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 32.0,
                                    ),
                                  ),

                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      // await _addToCart();
                                      if(alreadySelected == false) {
                                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                                      }

                                      /*Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            RetailClientProductsLst(
                                              sellerID: ,
                                            ),
                                      ));*/
                                    },
                                    child: Container(
                                      height: 65,
                                      margin: const EdgeInsets.only(
                                          left: 16
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "View Selected",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]
                    );
                  }

                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                }
            ),
            ActionBar(
              title: _headerName,
              hasTitle: true,
              hasBackArrow: true,
              hasHdrImg: true,
              headerImage: _headerImage,
            ),
          ],
        )
    );
  }
}
