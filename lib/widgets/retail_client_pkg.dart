import 'dart:async';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:ondago/screens/retail_client_products_lst.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/product_viewer.dart';
import 'package:ondago/widgets/action_bar.dart';
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
  late final String _selectedProductName = "selected-product-name";
  late String _selectedSellerName = "selected-product-name";
  late final String _selectedProductID = "selected-product-id";
  late String _selectedSellerID = "selected-seller-id";
  late String _selectedSellerSID = "selected-seller-sid";
  late final String _selectedProductSrvcID = "selected-product-service-id";
  late String _selectedSrvcCtgryName = "selected-service-name";
  late String _selectedSrvcCtgryID = "selected-service-id";
  late final String _selectedSrvcCtgryType = "selected-service-type";
  late final String _clientStore = "";
  late bool _isCustomerService;
  late Image _cardBckgrnd;
  late List _clientList;
  late List _rcRetailers;
  late List _testingList;

  late Icon _rcOpenNow;
  late Icon _rcNearBy;
  late Icon _rcHasItem;
  late Icon _rcDelivery;
  late Icon? _rcFtVegan;
  late Icon? _rcFtVegetarian;
  late Icon? _rcFtPescatarian;
  late Icon? _rcFtHalal;
  late Icon? _rcFtKosher;
  late Icon? _rcFtOmnivore;

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

  late CollectionReference _rcFTypesRef;
  // late DocumentReference _dsOpt;
  late String _rcID;
  late String _dsID;
  late String _dsOptID;

  late bool _halal;
  late bool _kosher;
  late bool _omnivore;
  late bool _pescatarian;
  late bool _vegan;
  late bool _vegetarian;

  final FirebaseServices _firebaseServices = FirebaseServices();

  Future _getRetailClientSrvcs() async {
    return await _firebaseServices.sellersRef
        .get()
        .then((dRetailClients) => {
          for (DocumentSnapshot dRc in dRetailClients.docs) {
            _rcID = dRc.reference.id,
            // print("drcAmt: ${dRetailClients.docs.length}"),
            if(dRc['openNow'] == true){
              _rcOpenNow = const Icon(Icons.meeting_room, color: Colors.deepOrangeAccent,),
            } else {
              _rcOpenNow = const Icon(Icons.no_meeting_room),
            },

            if(dRc['delivery'] == true){
              _rcDelivery = const Icon(Icons.delivery_dining, color: Colors.green,)
            } else {
              _rcDelivery = const Icon(Icons.delivery_dining_outlined)
            },

            if(dRc['hasItem'] == true){
              _rcHasItem = const Icon(Icons.add_shopping_cart)
            } else {
              _rcHasItem = const Icon(Icons.production_quantity_limits)
            },

            if(dRc['nearBy'] == true){
              _rcNearBy = const Icon(Icons.near_me, color: Colors.blue,),
            } else {
              _rcNearBy = const Icon(Icons.nearby_off)
            },

            _rcOpenNowLst.add(_rcOpenNow),
            _rcDeliveryLst.add(_rcDelivery),
            _rcHasItemLst.add(_rcHasItem),
            _rcNearByLst.add(_rcNearBy),

          },

        });
  }

  Future _getRetailClientOptions() async {
    late String? dsRcID;
    late bool? dsOptn;
    late String? dsRcName;
    int kl;
    late int? vegLstAmt;
    return await _firebaseServices.foodTypesGroupRef
      .get()
        .then((dRcOptions) => {
          // print("dsID: $dRcOptions")
          for(DocumentSnapshot dRcOpt in dRcOptions.docs) {
            // _dsOptn = dRcOpt['vegan'],
            _halal = dRcOpt['halal'],
            _kosher = dRcOpt['kosher'],
            _omnivore = dRcOpt['omnivore'],
            _pescatarian = dRcOpt['pescatarian'],
            _vegan = dRcOpt['vegan'],
            _vegetarian = dRcOpt['vegetarian'],
            _dsOptID = dRcOpt.reference.id,
            dsRcID = dRcOpt.reference.parent.parent?.id,
            print("dsRcID: $dsRcID, dsOptID: $_dsOptID"),

            if(_halal == true){
              _rcFtHalal = Icon(Icons.mosque, color: Colors.orange.shade700,),
              // _rcFtHalalLst?.add(_rcFtHalal),
              print('halal prods: $_dsOptID'),

            } else {
              _rcFtHalal = null
              // _rcFtHalal = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
            if(_kosher == true){
              _rcFtKosher = Icon(Icons.synagogue, color: Colors.brown.shade700,),
              // _rcFtKosherLst?.add(_rcFtKosher),
              print('kosher prods: $_dsOptID')

            } else {
              _rcFtKosher = null
              // _rcFtKosher = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
            if(_omnivore == true){
              _rcFtOmnivore = const Icon(Icons.kebab_dining, color: Colors.red,),
              // _rcFtOmnivoreLst?.add(_rcFtOmnivore),
              print('omnivore prods: $_dsOptID')

            } else {
              _rcFtOmnivore = null
              // _rcFtOmnivore = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
            if(_pescatarian == true){
              _rcFtPescatarian = Icon(Icons.set_meal, color: Colors.pink.shade200,),
              // _rcFtPescatarianLst?.add(_rcFtPescatarian),
              print('pescatarian prods: $_dsOptID')

            } else {
              _rcFtPescatarian = null
              // _rcFtPescatarian = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
            if(_vegan == true){
              _rcFtVegan = const Icon(Icons.grass, color: Colors.green,),
              // _rcFtVeganLst?.add(_rcFtVegan),
              print('vegan prods: $_dsOptID')

            } else {
              _rcFtVegan = null
              // _rcFtVegan = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
            if(_vegetarian == true){
              _rcFtVegetarian = Icon(Icons.grass_outlined, color: Colors.lightGreenAccent.shade200),
              // _rcFtVegetarianLst?.add(_rcFtVegetarian),
              print("vegetarian prods: $_dsOptID")
              // vegLstAmt = _rcFtVegetarianLst?.length,
              // print("vegetarian prods: $_dsOptID, LstAmt: $vegLstAmt, vegID: $_rcFtVegetarianLst")

            } else {
              _rcFtVegetarian = null
              // _rcFtVegetarian = Icon(Icons.disabled_by_default, color: Colors.black,),
            },
              // _rcFtHalal = null, _rcFtKosher = null,
              // _rcFtOmnivore = null, _rcFtPescatarian = null,
              // _rcFtVegan = null, _rcFtVegetarian = null,
              // _kl = _rcFtKosherLst.length,
              // print(" list: $_kl")
            // },

            /*if(dRcOpt['vegan'] == true){
              _rcFtVegan = Icon(Icons.grass, color: Colors.green,),
              _rcFtVeganLst?.add(_rcFtVegan),
              print("ddoc: ${_dsRcID}, val: vegan = ${_vegan}, icon: $_rcFtVegan"),
            } else {
              _rcFtVegan = null,
              // _rcFtVegan = Icon(Icons.grass_outlined),
            },

            if(dRcOpt['pescatarian'] == true){
              _rcFtPescatarian = Icon(Icons.set_meal_outlined,),
              _rcFtPescatarianLst?.add(_rcFtPescatarian),
              // print("ddoc: ${_dsRcID}, val: vegan = ${dRcOpt['vegan']}, icon: $_rcFtVegan"),
            } else {
              // _rcFtPescatarian = Icon(Icons.set_meal),
              _rcFtPescatarian = null,
            },

            if(dRcOpt['omnivore'] == true){
              _rcFtOmnivore = Icon(Icons.kebab_dining, color: Colors.red,),
              _rcFtOmnivoreLst?.add(_rcFtOmnivore),
              // print("ddoc: ${_dsRcID}, val: vegan = ${dRcOpt['vegan']}, icon: $_rcFtVegan"),
            } else {
              // _rcFtPescatarian = Icon(Icons.set_meal),
              _rcFtOmnivore = null,
            },*/

            // if(_rcFtHalal != null)
            _rcFtHalalLst.add(_rcFtHalal),
            // if(_rcFtKosher != null)
            _rcFtKosherLst.add(_rcFtKosher),
            // if(_rcFtOmnivore != null)
            _rcFtOmnivoreLst.add(_rcFtOmnivore),
            // if(_rcFtPescatarian != null)
            _rcFtPescatarianLst.add(_rcFtPescatarian),
            // if(_rcFtVegan != null)
            _rcFtVeganLst.add(_rcFtVegan),
            // if(_rcFtVegetarian != null)
            _rcFtVegetarianLst.add(_rcFtVegetarian),

          }
    });

  }

  // Check if service type for product or customer before requesting data

  @override
  void initState() {
    // TODO: Set this state top be MenuClosed State, Button State
    // _isCustomerService = "AnnNjTT8vmYSAEpT0rPg";
    _getRetailClientSrvcs();
    _getRetailClientOptions();
    super.initState();
  }

  void menuState() {
    // TODO: Set this state to be MenuOpen state, Menu State
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // print("amt: ${_rcFtVeganLst.length}");
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 1.235,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10),
        itemCount: widget.retailClientList.length,
        itemBuilder: (BuildContext ctx, int index) {
          // ** Sellers Builder being Build ** //
          // print("indesList: ${_rcHasItemLst}");
          return StreamBuilder(
            stream: _firebaseServices.sellersRef
                // .orderBy("name", descending: false)
                .snapshots(),
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

              //TODO: Must fix index error when loading data
              // ******************************************** //
              if(sellerSnap.connectionState == ConnectionState.active) {
                if(sellerSnap.hasData) {
                  _rcRetailers = sellerSnap.data.docs;
                  return Container(
                    alignment: Alignment.topCenter,
                    // width: screenWidth,
                    // height: screenHeight,
                    margin: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    padding: const EdgeInsets.symmetric (
                        vertical: 0,
                        horizontal: 0
                    ),
                    // height: 100,
                    child: GestureDetector(
                          onTap: () async {
                            _selectedSellerName = "${_rcRetailers[index]['name']}";
                            _selectedSellerID = "${_rcRetailers[index].id}";
                            _selectedSellerSID = "${_rcRetailers[index]['sellerID']}";
                            _selectedSrvcCtgryName = widget.serviceCategoryName;
                            _selectedSrvcCtgryID = widget.serviceCategoryID;
                            // _selectedProductID = "${_rcRetailers[index]['prodID']}";
                            // _selectedProductID =
                            // _prodSelected = true;
                            // _isProductSelected(prodID);
                            setState(() {
                              // _isSelected = index;
                              print("_selectedSellerName: $_selectedSellerName | _selectedSellerID: $_selectedSellerID");
                            });

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                              RetailClientProductsLst(
                                selectedSellerSID: _selectedSellerSID,
                                selectedSellerName: _selectedSellerName,
                                // selectedProductID: ,
                              ),
                            ));
                          },
                          /*child: Container(
                              child: ClipRRect (
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                    "${_rcRetailers[index]['logo']}",
                                    fit: BoxFit.fill,
                                  )
                              )
                          )*/
                          child: RetailClientCard(
                            retailClientBnr: "${_rcRetailers[index]['logo']}",
                            retailClientName: "${_rcRetailers[index]['name']}",
                            retailClientRating: "${_rcRetailers[index]['rating']}",
                            retailClientSrvcs: [
                              _rcOpenNowLst[index],
                              _rcDeliveryLst[index],
                              _rcHasItemLst[index],
                              _rcNearByLst[index],
                            ],
                            retailClientStatus: [
                              // _rcOpenNowLst[index],
                              // _rcDeliveryLst[index],
                              // _rcHasItemLst[index],
                              // _rcNearByLst[index],
                              _rcFtHalalLst[index],
                              _rcFtKosherLst[index],
                              _rcFtOmnivoreLst[index],
                              _rcFtPescatarianLst[index],
                              _rcFtVeganLst[index],
                              _rcFtVegetarianLst[index],

                            ],
                          )

                        )


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
    );
  }
}


/// ********** class seperation ********** ///


class RetailClientProductsLst extends StatefulWidget {
  final String selectedSellerSID;
  final String? sellerID;
  final String selectedSellerName;
  final String? selectedSrvcCtgryName;
  final String? selectedSrvcCtgryID;
  final String? selectedProductName;
  final String? selectedProductID;
  final Function? onPressed;
  const RetailClientProductsLst({
    super.key,
    required this.selectedSellerSID,
    this.sellerID,
    this.selectedSrvcCtgryName,
    this.selectedSrvcCtgryID,
    this.selectedProductName,
    this.selectedProductID,
    required this.selectedSellerName,
    this.onPressed,
  });

  @override
  _RetailClientProductsLstState createState() => _RetailClientProductsLstState();
}

class _RetailClientProductsLstState extends State<RetailClientProductsLst> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  late List _prodData;
  late final String _selectedSellerName = widget.selectedSellerName;
  late final String _selectedSellerSID = widget.selectedSellerSID;
    // return prod;
    // print("${snapshot.}product unselected!")
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ActionBar(
        title: _selectedSellerName ?? "Service Products",
        hasTitle: true,
        hasBackArrow: true,
      ),
      body:
        StreamBuilder<QuerySnapshot>(
        // get all selected documents from SelectedProducts
          stream: _firebaseServices.productsRef
              .where("retailerID", isEqualTo: _selectedSellerSID)
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
                // print("prodID: ${_prodData[0]['name']}");
                // Collect Selected docs into array / ListView
                // display data in listview
                return Stack(
                  children: [
                    ListView.builder (
                      padding: const EdgeInsets.only(top: 200),
                      itemCount: _prodData.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print("client product name = ${_prodData[index]['name']}");
                        return Column (
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              ProductViewer(
                                // isSelected: index,
                                prodPrice: _prodData[index]['price'],
                                prodPID: _prodData[index]['prodID'],
                                prodImg: _prodData[index]['images'][0],
                                prodName: _prodData[index]['name'],
                                prodDesc: _prodData[index]['desc'],
                                prodSrvcName: _prodData[index]['srvc'],
                                isSelected: _prodData[index]['isSelected'],
                                // prodSellers: [''],
                                prodSrvcID: _prodData[index]['srvcID'],
                                srvcProdID: _prodData[index].id,
                              )
                          ]
                        );
                      },

                  ),
                    Container(
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
                      /*child: Image.network(
                              "${_headerImage}",
                              fit: BoxFit.contain,
                            ),*/
                    ),
                  ]
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


    );
  }
}