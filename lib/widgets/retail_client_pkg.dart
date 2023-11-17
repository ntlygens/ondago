import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:ondago/screens/retail_client_products_lst.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/product_viewer.dart';
import 'package:ondago/widgets/action_bar.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/widgets/retail_client_card.dart';


class RetailClientPkg extends StatefulWidget {
  final List retailClientList;
  final String serviceCategoryName;
  final String serviceCategoryID;
  final Function(String)? onSelected;
  const RetailClientPkg({
    required this.retailClientList,
    this.onSelected,
    required this.serviceCategoryName,
    required this.serviceCategoryID,
    super.key
  });

  @override
  _RetailClientPkgState createState() => _RetailClientPkgState();
}

class _RetailClientPkgState extends State<RetailClientPkg> {
  final String _selectedProductName = "selected-product-name";
  String? _selectedSellerName = "selected-product-name";
  final String _selectedProductID = "selected-product-id";
  String _selectedSellerID = "selected-product-id";
  final String _selectedProductSrvcID = "selected-product-service-id";
  String _selectedSrvcCtgryName = "selected-service-name";
  String _selectedSrvcCtgryID = "selected-service-id";
  final String _selectedSrvcCtgryType = "selected-service-type";
  late bool _isCustomerService;
  late Image _cardBckgrnd;
  String _clientStore = "";
  late List _clientList;

  late Icon _rcOpenNow;
  late Icon _rcNearBy;
  late Icon _rcHasItem;
  late Icon _rcDelivery;
  late Icon _rcFtVegan;
  late Icon _rcFtVegetarian;
  late Icon _rcFtPescatarian;
  late Icon _rcFtHalal;
  late Icon _rcFtKosher;
  late Icon _rcFtOmnivore;
  final List _rcOpenNowLst = [];
  final List _rcNearByLst = [];
  final List _rcHasItemLst = [];
  final List _rcDeliveryLst = [];
  final List _rcFtVeganLst = [];
  final List _rcFtVegetarianLst = [];
  final List _rcFtPescatarianLst = [];
  final List _rcFtHalalLst = [];
  final List _rcFtKosherLst = [];
  final List _rcFtOmnivoreLst = [];

  final List _rcFoodTypeLst = [];

  late String _rcID;
  late bool _vegan;
  late bool _vegetarian;
  late bool _pescatarian;
  late bool _halal;
  late bool _kosher;
  late bool _omnivore;


  // late String _rcFT = "";

  final FirebaseServices _firebaseServices = FirebaseServices();

  /*Future _isProductSelected(prodID) {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .where('prodID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs){
            if(ds.reference.id == prodID ) {
              print("${ds.reference.id } product!")
            } else {
              _selectServiceProduct()
            }
            // ds.reference.update({'isSelected': false})
          },
        });

    // return prod;
      // print("${snapshot.}product unselected!")
  }*/

  Future _getRetailClientSrvcs() async {
    late CollectionReference _rcFTypesRef;
    late String ty;
    // late List _rcFtVeganLst = [];
    return await _firebaseServices.sellersRef
        .get()
        .then((dRetailClients) => {
          for (DocumentSnapshot dRc in dRetailClients.docs) {
            _rcID = dRc.reference.id,
            if(dRc['openNow'] == true){
              _rcOpenNow = Icon(Icons.meeting_room, color: Colors.deepOrangeAccent,),
              // print("${dRc.id} = $_rcOpenNow")
            } else {
              _rcOpenNow = Icon(Icons.no_meeting_room),
            },

            if(dRc['delivery'] == true){
              _rcDelivery = Icon(Icons.delivery_dining, color: Colors.green,)
            } else {
              _rcDelivery = Icon(Icons.delivery_dining_outlined)
            },

            if(dRc['hasItem'] == true){
              _rcHasItem = Icon(Icons.add_shopping_cart)
            } else {
              _rcHasItem = Icon(Icons.production_quantity_limits)
            },

            if(dRc['nearBy'] == true){
              _rcNearBy = Icon(Icons.near_me, color: Colors.blue,),
              // print("${dRc.id} = $_rcNearBy")
            } else {
              _rcNearBy = Icon(Icons.nearby_off)
            },

            _rcOpenNowLst.add(_rcOpenNow),
            _rcDeliveryLst.add(_rcDelivery),
            _rcHasItemLst.add(_rcHasItem),
            _rcNearByLst.add(_rcNearBy),

            // _client = dRc['hasItem'],
            // print ('client: $_rcHasItemLst')
          },

          for(DocumentSnapshot dDoc in dRetailClients.docs){
            _rcID = dDoc.reference.id,
            _rcFTypesRef = _firebaseServices.sellersRef.doc(_rcID).collection('foodType'),
            _rcFTypesRef.get()
                .then((value) => {
                  for (DocumentSnapshot ds in value.docs) {
                    // print("dddsss: ${ds['vegan']}"),
                    if(ds['vegan'] == true)
                      _rcFtVegan = Icon(Icons.grass, color: Colors.green, )
                    else
                      _rcFtVegan = Icon(Icons.grass_outlined),

                    print("doc: ${_rcID}, val: vegan = ${ds['vegan']}, icon: $_rcFtVegan"),

                    _rcFtVeganLst.add(_rcFtVegan)
                  }
                }
                /*.then((value) => value.docs
                  .forEach((element) {
                    // var rcFTData = element.data();
                    var docRef = element.id;
                    // _vegan = element['vegan'];
                    if(element['vegan'] == true)
                      _rcFtVegan = Icon(Icons.grass, color: Colors.green, );
                    else
                      _rcFtVegan = Icon(Icons.grass_outlined);

                    print("doc: ${docRef}, val: vegan = ${element['vegan']}, icon: $_rcFtVegan");

                    _rcFtVeganLst.add(_rcFtVegan);
                    // print("veganList: ${_rcFtVeganLst}");
                  })*/
                ),
          }
        });
  }

  Future _selectRetailClients<String>() async {
    late List _clientList;
    _firebaseServices.sellersRef
        .get()
        .then((retailclients) => {
          for( DocumentSnapshot rc in retailclients.docs) {
            _clientStore = rc.id,
            print("retailer Name: ${rc['name']} -- clientStoreID: $_clientStore"),
          }
        });
    return _clientStore;
  }

  Future _selectServiceProduct() async {
      return _firebaseServices.usersRef
          .doc(_firebaseServices.getUserID())
          .collection("SelectedService")
          .doc()
          .set({
        "prodName": _selectedProductName,
        "prodID": _selectedProductID,
        "srvcCtgry": _selectedSrvcCtgryName,
        "srvcCtgryID": _selectedSrvcCtgryID,
        "date": _firebaseServices.setDayAndTime(),
      }).then((_) {
        print(
            "Name: $_selectedProductName | ID: $_selectedProductID Selected");
        _setProductIsSelected(_selectedProductID);
      });
  }

  Future _selectSellerProduct() async {
      return _firebaseServices.usersRef
          .doc(_firebaseServices.getUserID())
          .collection("SelectedSeller")
          .doc()
          .set({
        "sellerName": _selectedSellerName,
        "sellerID": _selectedSellerID,
        "srvcCtgry": _selectedSrvcCtgryName,
        "srvcCtgryID": _selectedSrvcCtgryID,
        "date": _firebaseServices.setDayAndTime(),
      }).then((_) {
        print(
            "Name: $_selectedProductName | ID: $_selectedProductID Selected");
        _setProductIsSelected(_selectedProductID);
      });
  }

  Future _selectCustomerService() async {
    return _firebaseServices.customerSrvcsRef
        .doc(_firebaseServices.getUserID())
        .collection("CustomerServices")
        .doc()
        .set({
          "prodName": _selectedProductName,
          "prodID": _selectedProductID,
          "srvcCtgry": _selectedSrvcCtgryName,
          "srvcCtgryID": _selectedSrvcCtgryID,
          "date": _firebaseServices.setDayAndTime(),
        })
        .then((_) {
          print("Name: $_selectedProductName | ID: $_selectedProductID Selected");
          _setProductIsSelected(_selectedProductID);
        });
  }

  Future _setProductIsSelected(value) async {
    return _firebaseServices.productsRef
        .doc(value)
        .update({"isSelected": true})
        .then((_) {
          // _selectServiceProduct();
          print("selection done");
        });
  }

  Future _setSellerIsSelected(value) async {
    return _firebaseServices.sellersRef
        .doc(value)
        .update({"isSelected": true})
        .then((_) {
          // _selectServiceProduct();
          print("selection done");
        });
  }

  // Check if service type for product or customer before requesting data

  @override
  void initState() {
    // TODO: Set this state top be MenuClosed State, Button State
    // _isCustomerService = "AnnNjTT8vmYSAEpT0rPg";
    _getRetailClientSrvcs();
    super.initState();
  }

  void menuState() {
    // TODO: Set this state to be MenuOpen state, Menu State
  }


  @override
  Widget build(BuildContext context) {
    // print("amt: ${widget.retailClientList.length}");
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8
      ),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 1.35,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.retailClientList.length,
          itemBuilder: (BuildContext ctx, index) {
            // ** Sellers Builder being Build ** //
            // print("indesList: ${_rcHasItemLst}");
            return FutureBuilder(
              future: _firebaseServices.sellersRef
                  .doc("${widget.retailClientList[index]}")
                  .get(),
              builder: (context, AsyncSnapshot sellerSnap) {
                if(sellerSnap.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "RetailersListError: ${sellerSnap.error}"
                      ),
                    ),
                  );
                }

                if(sellerSnap.connectionState == ConnectionState.done) {
                  if(sellerSnap.hasData) {
                    // print("list item = ${widget.retailClientList[index]}");
                    // print("ID: ${sellerSnap.data!['sellerID']} -- Name: ${sellerSnap.data!['name']}");
                    // print('hasItem: ${_rcHasItemLst[index]}, amd ${_rcDeliveryLst[index]}');
                    // print("veganList: ${_rcFtVeganLst[index]}");
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5
                      ),
                      // height: 100,
                      child: GestureDetector(
                        onTap: () async {
                          _selectedSellerName = "${sellerSnap.data!['name']}";
                          _selectedSellerID = "${sellerSnap.data!.id}";
                          _selectedSrvcCtgryName = widget.serviceCategoryName;
                          _selectedSrvcCtgryID = widget.serviceCategoryID;
                          // _prodSelected = true;
                          setState(() {
                            // _isSelected = index;
                          });

                          // print("datentime: ${_firebaseServices.setDayAndTime()}");

                          // await _isProductSelected(sellerSnap.data.id);
                          // await _selectServiceProduct();
                          // await _setProductIsSelected(_selectedProductID);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                // Text("this is itext")
                                RetailClientProductsLst(
                                  sellerID: "${sellerSnap.data!['sellerID']}",
                                ),
                          ));
                        },
                        /*child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Stack(
                              children: [
                                Image.network("${sellerSnap.data!['logo']}"),
                                Padding(
                                    padding: EdgeInsets.all(
                                      15
                                      // vertical: 15,
                                      // horizontal: 5
                                    ),
                                    child: Text("dt: ${sellerSnap.data!['phone']}"),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                      5
                                    ),
                                    child: Text("et: ${sellerSnap.data!['cuisine']}"),
                                ),
                              ]
                          ),
                        ),*/
                        child: RetailClientCard(
                          retailClientBnr: "${sellerSnap.data!['logo']}",
                          retailClientName: "${sellerSnap.data!['name']}",
                          retailClientRating: "${sellerSnap.data!['rating']}",
                          retailClientSrvcs: [
                            _rcOpenNowLst[index],
                            _rcDeliveryLst[index],
                            _rcHasItemLst[index],
                            _rcNearByLst[index],
                          ],
                          retailClientStatus: [
                            _rcFtVeganLst,
                          ],
                        )

                        /// *** Currently Working *** ///
                        /*child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                            // 8
                            vertical: 12,
                            horizontal: 8,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    "${sellerSnap.data!['logo']}",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8
                                ),
                                child: Text (
                                    "${sellerSnap.data['name']}",
                                  style: Constants.boldHeading,
                                ),
                              ),

                              Text ("${sellerSnap.data!['rating']}"),
                            ],
                          ),
                        ),*/
                        /// ************************* ///

                        /*child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                            // 0
                            vertical: 24,
                            horizontal: 0,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            fit: StackFit.loose,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 0
                                ),
                                // alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child:
                                    _isCustomerService ?
                                    Image.network("${sellerSnap.data!['images'][0]}")
                                        : Image.network("${sellerSnap.data!['logo']}"
                                    ),
                                ),
                              ),
                              Text("${sellerSnap.data!['phone']}"),
                              Text("${sellerSnap.data!['rating']}"),
                              Text("${sellerSnap.data!['phone']}"),
                            ],
                          ),
                        ),*/
                      ),
                    );
                  }

                }

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
            // *************************************** //
          }
      ),
    );
  }
}


/// ********** class seperation ********** ///


class RetailClientProductsLst extends StatefulWidget {
  final String? sellerID;
  final Function? onPressed;
  RetailClientProductsLst({super.key,  this.onPressed, required this.sellerID});

  @override
  _RetailClientProductsLstState createState() => _RetailClientProductsLstState();
}

class _RetailClientProductsLstState extends State<RetailClientProductsLst> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  late List _prodData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            // get all selected documents from SelectedService
              stream: _firebaseServices.productsRef
                  .where("retailerID", isEqualTo: widget.sellerID)
              // .orderBy("name", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if( snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("RetailClientProductsPage-Error: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.active) {
                  if(snapshot.hasData){
                    _prodData = snapshot.data!.docs;
                    print("prodID: ${_prodData[0]['name']}");
                    // Collect Selected docs into array / ListView
                    // display data in listview
                    return ListView.builder (
                      itemCount: _prodData.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print("client product name = ${_prodData[index]['name']}");
                        return Column(
                          /*padding : EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),*/
                          // children: [
                          // children: _prodData.map((_prodData, index) =>
                          ///// for (var i = 0; i < _prodData.length; i++)
                          // seperate array into individual documents
                          /*child: Text(
                              "thisiis retail client product list page"
                            ),*/

                            children: [
                              ProductViewer(
                                // isSelected: index == 0,
                                prodPID: _prodData[index]['prodID'],
                                prodName: _prodData[index]['name'],
                                // prodSellers: [''],
                                srvcProdID: _prodData[index].id,
                              ),
                            ]
                          // ]
                        );
                      },

                    );
                  }
                }

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
          ),
          ActionBar(
            title: "Service Products",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}