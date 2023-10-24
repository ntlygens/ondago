// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/screens/service_products_page.dart';
import 'package:ondago/services/firebase_services.dart';

class CategoryTypes extends StatefulWidget {
  final List categoryTypeList;
  final String serviceCategoryName;
  final String serviceCategoryID;
  final String serviceCategoryType;
  final Function(String)? onSelected;
  const CategoryTypes({
    required this.categoryTypeList,
    this.onSelected,
    required this.serviceCategoryName,
    required this.serviceCategoryID,
    required this.serviceCategoryType,
  });

  @override
  _CategoryTypesState createState() => _CategoryTypesState();
}

class _CategoryTypesState extends State<CategoryTypes> {
  final String _selectedProductName = "selected-product-name";
  String? _selectedSellerName = "selected-product-name";
  final String _selectedProductID = "selected-product-id";
  String _selectedSellerID = "selected-product-id";
  final String _selectedProductSrvcID = "selected-product-service-id";
  String _selectedSrvcCtgryName = "selected-service-name";
  String _selectedSrvcCtgryID = "selected-service-id";
  final String _selectedSrvcCtgryType = "selected-service-type";

  late bool _isCustomerService;
  late var _slctdSrvc;
  late Image _cardBckgrnd;

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
  Future _checkServiceType() async {
    _isCustomerService = false;

    if( widget.serviceCategoryType == "customer") {
      _isCustomerService = true;
      print('${widget.serviceCategoryName} is a customer servcice');
    }
    print('${widget.serviceCategoryName} is a ${widget.serviceCategoryType} servcice');


  }

  @override
  void initState() {
    // _isCustomerService = "AnnNjTT8vmYSAEpT0rPg";
    print("${widget.serviceCategoryType} is the srvcCatType");
    _checkServiceType();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print("amt: ${widget.categoryTypeList.length}");
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.categoryTypeList.length,
          itemBuilder: (BuildContext ctx, index) {
            if(_isCustomerService) {
              _slctdSrvc = _firebaseServices.customerSrvcsRef;
            } else {
              _slctdSrvc = _firebaseServices.sellersRef;
            }

            // ** Sellers StreamBuilder being Build ** //
            return StreamBuilder(
              stream: _slctdSrvc
                  .doc("${widget.categoryTypeList[index]}")
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

                if(sellerSnap.connectionState == ConnectionState.active) {
                  if(sellerSnap.hasData) {

                    // print("list item = ${widget.categoryTypeList[index]}");
                    print("ID: ${sellerSnap.data.id} \n Name: ${sellerSnap.data!['name']}");
                    return GestureDetector(
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
                        await _selectServiceProduct();
                        // await _setProductIsSelected(_selectedProductID);

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              ServiceProductsPage(
                                isCstmrSrvc: _isCustomerService
                              ),
                        ));
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          // 8
                          vertical: 11,
                          horizontal: 27,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child:
                                  _isCustomerService ?
                                  Image.network("${sellerSnap.data!['images'][0]}")
                                      : Image.network("${sellerSnap.data!['logo']}"
                                  ),
                              ),
                            ),
                          ],
                        ),
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
