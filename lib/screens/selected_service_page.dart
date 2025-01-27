import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';
import 'package:ondago/widgets/retail_client_pkg.dart';


class SelectedServicePage extends StatefulWidget {
  final String serviceID;
  final String serviceType;
  final String? headerImg;
  final String? headerName;

  const SelectedServicePage({super.key, required this.serviceID, required this.serviceType, this.headerImg, this.headerName});

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
  late String _odmPOS;

  Future _odmPOSDataCheck<String>() async {
    return await _firebaseServices.odmPOS_ProdChstRef
        .get()
        .then((posItems) {
        // .then((posItems) => posItems.docs
          // .forEach((posItems) {
          for(DocumentSnapshot posItem in posItems.docs) {
            _odmPOS = posItem.id;
            print("odmPosItem: $_odmPOS");
          }
        });

  }

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
        .collection("Cart")
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


  Future<void> addAProduct() async {
    // Create a reference to the 'products' collection
    // CollectionReference products = FirebaseFirestore.instance.collection('products');

    // Set the data for the new document in the 'products' collection
    return _firebaseServices.productsRef.add({
      'name': 'al',
      'prodID': 'prod-001',
      'SID': 'sid-001',
      'date': FieldValue.serverTimestamp(), // Sets the current server timestamp
    }).then((value) {
      print("Product Added");
    }).catchError((error) {
      print("Failed to add product: $error");
    });
  }

  Future<void> addProducts() async {
    // final CollectionReference productsRef = _firebaseServices.productsRef;
    // CollectionReference products = FirebaseFirestore.instance.collection('products');

    final items = [
      "Bruschetta",
      "Caprese Salad",
      "Arancini",
      "Calamari Fritti",
      "Prosciutto e Melone",
      "Caesar Salad",
      "Panzanella",
      "Arugula Salad",
      "Spinach and Strawberry Salad",
      "Spaghetti Carbonara",
      "Fettuccine Alfredo",
      "Penne Arrabbiata",
      "Lasagna",
      "Gnocchi al Pesto",
      "Chicken Parmigiana",
      "Osso Buco",
      "Veal Marsala",
      "Grilled Salmon",
      "Eggplant Parmigiana",
      "Garlic Bread",
      "Grilled Vegetables",
      "Mashed Potatoes",
      "Sautéed Spinach",
      "Roasted Potatoes",
      "Tiramisu",
      "Cannoli",
      "Panna Cotta",
      "Gelato",
      "Affogato",
      "Espresso",
      "Cappuccino",
      "Limoncello",
      "Italian Soda",
      "Sparkling Water",
    ];

    for (String item in items) {
      await _firebaseServices.odmPOS_ProdChstRef.add({
        "desc": "This is a delicious $item, perfect for any occasion.",
        "images": [
          "https://example.com/image1.jpg",
        ],
        "isSelected": false,
        "isVisible": true,
        "name": item,
        "price": 2.50,
        "prodID": "${item}_000",
        "sellerID": ["sid-000-000"],
        "service": "menu",
        "serviceID": "menu-${item}-00000",
        "serviceType": [""],
        "category": [""],
        "date": DateTime.now(),
      }).then((value) {
            print("Product Added $value");
          }).catchError((error) {
            print("Failed to add product: $error");
          });
    }
  }

  Future<void> addItemsToFirestore() async {
    final CollectionReference productsRef = _firebaseServices.productsRef;

    List<Map<String, dynamic>> items = [
      {
        "desc": "A classic Italian starter with toasted bread topped with tomatoes, garlic, and olive oil.",
        "images": ["https://example.com/image1.jpg", "https://example.com/image2.jpg", "https://example.com/image3.jpg"],
        "isSelected": false,
        "name": "Bruschetta",
        "price": 2.00,
        "prodID": "Appetizers_001",
        "retailerID": "Sid-001",
        "seller": "seller_name",
        "srvc": "menu",
        "srvcID": "menuID11032",
        "type": ["Apple", "Banana", "Grapes"]
      },
      {
        "desc": "Fresh mozzarella, tomatoes, and basil drizzled with balsamic glaze.",
        "images": ["https://example.com/image1.jpg", "https://example.com/image2.jpg", "https://example.com/image3.jpg"],
        "isSelected": false,
        "name": "Caprese Salad",
        "price": 2.00,
        "prodID": "Appetizers_002",
        "retailerID": "Sid-001",
        "seller": "seller_name",
        "srvc": "menu",
        "srvcID": "menuID11032",
        "type": ["Orange", "Kiwi", "Strawberry"]
      },
      // Add more items here...
    ];

    for (var item in items) {
      await productsRef.add(item);
    }
  }

  Future<void> _updateProducts() async {
    return _firebaseServices.odmPOS_ProdChstRef
        .where("service", isEqualTo: "menu")
    // .where("srvc", arrayContains: "")
        .get()
        .then((prodItems) {
          for(DocumentSnapshot prodItem in prodItems.docs) {
            prodItem.reference.update({"retailerID": "sid-001-201"});

          };
          print("products updated");

    });

  }






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
    _odmPOSDataCheck();
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
        appBar: const ActionBar(
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
                // print("headerImg: $_headerImage");
                return Stack(
                  alignment: AlignmentDirectional.topCenter,
                  fit: StackFit.loose,
                  children: [
                    // Text ("${snapshot.data['name']}"),
                    ListView(
                      padding: const EdgeInsets.only(top:250),
                      children: [
                          /// List of Products by Slctd Srvc ///
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0
                            ),
                            /*child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                // 8
                                vertical: 11,
                                horizontal: 16,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      *//*child: Text(
                                                  "${_srvcDataList[index]['name']}"
                                                ),*//*
                                      child: Image.network(
                                        "${snapshot.data['images'][0]}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text ("${snapshot.data['name']}"),
                                ],
                              ),
                            ),*/

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
                                      // await addProducts();
                                      // await _updateProducts();
                                      print('button clicked');

                                      /*if(alreadySelected == false) {
                                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                                      }*/

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

                    /*Container(
                      width: screenWidth,
                      height: 135,
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(
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
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                          // BoxShadow(color: Colors.deepOrange, sprea`dRadius: 3),
                        ],
                      ),
                      child: const Text("rhis is he thse"),
                      // child: Image.network(
                      //         "${_headerImage}",
                      //         fit: BoxFit.contain,
                      //       ),
                    ),*/
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
