import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/screens/retail_client_products_lst.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';
import 'package:ondago/widgets/app_bar_search.dart';
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
  late bool _notCustomerSrvc;
  late String? _headerImage;
  late String? _headerName;

  Future _checkSrvcType<String>() async {
    _isCustomerSrvc = false;
    _notCustomerSrvc = true;
    if(widget.serviceType == 'customer') {
      _isCustomerSrvc = true;
      _notCustomerSrvc = false;
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
        .collection("SelectedProducts")
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
        .collection("SelectedProducts")
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
        .collection("SelectedProducts")
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: ActionBar(
          title: 'Hme',
          hasTitle: true,
          hasBackArrow: true,
          hasCounter: true,
        ),

        body: FutureBuilder<DocumentSnapshot>(
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
                List docs = snapshot.data['type'];
                print("headerIme: $_headerImage");
                return Stack(
                  alignment: AlignmentDirectional.topCenter,
                  fit: StackFit.loose,
                  children: [
                    // Text ("${snapshot.data['name']}"),
                    ListView(
                      padding: const EdgeInsets.only(top:250),
                      children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0
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
                    ),

                    Container(
                      width: screenWidth,
                      height: 135,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 0, 40
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.deepOrange,
                            width: 3,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignCenter
                        ),
                        borderRadius: BorderRadius.circular(6),
                        // color: Colors.deepOrange,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.45),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                          // BoxShadow(color: Colors.deepOrange, sprea`dRadius: 3),
                        ],
                      ),
                      child: Text("rhis is he thse"),
                      /*child: Image.network(
                              "${_headerImage}",
                              fit: BoxFit.contain,
                            ),*/
                    ),
                  ],
                );
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }
        )
    );
  }
}
