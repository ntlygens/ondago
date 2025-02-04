import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ondago/widgets/prod_view_desc.dart';

class ProductViewer extends StatefulWidget {
  final String? prodPID;
  final String? prodName;
  final String? prodDesc;
  final num? prodPrice;
  final String? prodSrvcName;
  final String? prodSrvcID;
  final String? prodSrvcType;
  final String? srvcProdID;
  final bool? isSelected;
  final List? prodSellers;
  final String? prodImg;
  const ProductViewer({super.key, 
    this.prodPID,
    this.isSelected,
    this.prodName,
    this.prodDesc,
    this.prodPrice,
    this.prodSrvcName,
    this.prodSrvcID,
    this.prodSrvcType,
    this.srvcProdID,
    this.prodSellers,
    this.prodImg
  });

  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  late final String? _prodName = widget.prodName;
  late final String? _prodDesc = widget.prodDesc;
  late final String? _prodPID = widget.prodPID;
  late final String? _prodImg = widget.prodImg;
  late final bool? _isSelected = widget.isSelected;
  late final num? _prodPrice = widget.prodPrice;
  late final String? _prodSrvcName = widget.prodSrvcName;
  late final String? _prodSrvcID = widget.prodSrvcID;
  late final String? _srvcProdID = widget.srvcProdID;

  late bool _isOpen = _isSelected ?? false;

  /*Future<void> writeToSecondaryDatabase(String data) async {
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
  }*/

  /*Future<void> createRoom(collection, docid, data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc("doc_Id")
        .set(data);

    // simply add a document in messages sub-collection when needed.
  }*/
  
  Future _selectServiceProduct() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        .doc()
        .set({
      "prodName": _prodName,
      "prodID": _prodPID,
      "prodImg": _prodImg,
      "srvcCtgry": _prodSrvcName,
      "srvcCtgryID": _prodSrvcID,
      "srvcProdID": _srvcProdID,
      "date": _firebaseServices.setDayAndTime(),
    }).then((_) {
      // _isProductSelected(_srvcProdID);
      // _setProductIsSelected(_srvcProdID);
      print("Name: $_prodName | Prod-Srvc-Type-ID: $_prodSrvcID | PID: $_prodPID Selected | SrvcProdID: $_srvcProdID has been added to your cart!");

    });
  }

  /*Future _isProductSelected(prodID) {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        .where('srvcProdID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
            for (DocumentSnapshot ds in snapshot.docs){
              // print("ProdItem: ${ds['srvcProdID']} -- ${ds['prodName']} product already in cart!"),
              if( snapshot.docs.length > 0 ) {
                print("ProdItem: ${ds['srvcProdID']} -- ${ds['prodName']} product already in cart!"),
              } else {
                print("Adding product to cart"),
                _setProductIsSelected(prodID),
              }
              // ds.reference.update({'isSelected': false})
            },
          });
  }*/

  Future _isProductSelected(prodID) {
    return _firebaseServices.productsRef
        .doc(prodID)
        .get()
        .then((snapshot) => {
            // for (DocumentSnapshot ds in snapshot.docs){
              // print("ProdItem: ${ds['srvcProdID']} -- ${ds['prodName']} product already in cart!"),
              if( snapshot['isSelected'] == true ) {
                print("ProdItem: ${snapshot.id} -- ProdID: ${snapshot['prodID']} -- ProdName: ${snapshot['name']} already in cart!"),
              } else {
                  print("Adding product to cart"),
                  _setProductIsSelected(prodID),
              }
              // ds.reference.update({'isSelected': false})
            // },
          });
  }

  Future _setProductIsSelected(value) async {
    return _firebaseServices.productsRef
        .doc(value)
        .update({"isSelected": true})
        .then((_) {
          print("selection done");
          setState(() {
            _isOpen = true;
          });
          _selectServiceProduct();
        });
  }


  /*Future _selectSellerProduct() async {
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
          "Name: _selectedProductName | ID: _selectedProductID Selected");
      // _setProductIsSelected(_selectedProductID);
    });
  }*/

  /*Future _selectCustomerService() async {
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
      print("Name: _selectedProductName | ID: _selectedProductID Selected");
      // _setProductIsSelected(_selectedProductID);
    });
  }*/


  Future _setSellerIsSelected(value) async {
    return _firebaseServices.sellersRef
        .doc(value)
        .update({"isSelected": true})
        .then((_) {
      // _selectServiceProduct();
      print("selection done");
    });
  }
  
  
  
  Future _removeServiceProduct(value) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        // .collection("SelectedProducts")
        .doc(value)
        .delete()
        .then((_) {
          _resetProductIsSelected(value);
          // _refreshServiceProduct();
          print("product $value removed");
    });
  }

  Future _resetProductIsSelected(value) async {
    return _firebaseServices.productsRef
        .doc(value)
        .update({"isSelected" : false})
        .then((_) {
          print("product $value UnSelected");
          _refreshServiceProduct;
          // _removeServiceProduct(widget.srvcProdID);
        });
  }

  Future _refreshServiceProduct() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedProducts")
        .orderBy("date", descending: true)
        .get()
        .then((_) {
          print("list refreshed");
        });

  }

  Future _getProductSellers() async {
    return _firebaseServices.productsRef
        .doc(_prodPID)
        // .doc(widget.prodPID)
        .snapshots().where((event) => event['type']);
        // .get();
        // .then((value) => value['type']);
  }

/*Future _getAltProduct() async {
    late List dList = [];
    // var bList = [];
    return _firebaseServices.productsRef
      .doc(widget.prodPID)
      .snapshots();
      // .where("name",
        // isNull: true,
        isEqualTo: widget.prodName
        // arrayContains: ""
      // )
      // .orderBy("seller")
    ;
    dSellers.get()
        .then((value) => value.docs
        .forEach((element) {
      bList.add(element['type']);
      // print("el ${element['type']}");
      // print("list: ${dList}");
      // return element['type'];
       // dList;
    }));
    print("list: ${bList}");
    return dSellers;
  }*/


  @override
  void initState() {
     // _getAltProduct();
    // _getProductSellers();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // bool isSelected = _isSelected!;
    num _price = _prodPrice ?? 0;
    // String _image = _prodImg ?? '';
    // print('isSelected = $isSelected');
    return Column(
      children: [
          Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 6
            ),
            child: GestureDetector(
              onTap: () => {_isProductSelected(_srvcProdID), setState(() {_isOpen = true;})},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        // width: 300,
                        decoration: BoxDecoration(
                          color: _isOpen! ? Colors.amberAccent : Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // height: _isSelected ? 300 : 55,
                        height: _isOpen! ? 200 : 80,
                        alignment: Alignment.topLeft,

                        margin: const EdgeInsets.all(
                          3,
                        ),
                        padding: EdgeInsets.fromLTRB(
                            8, 6, 8, 8
                        ),
                        // margin: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Text(
                              "${_prodName}",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: _isOpen! ? Colors.black12 : Colors.black45,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${_prodDesc}",
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: 1.1,
                                color: _isOpen! ? Colors.black12 : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*child: ProdViewDesc(
                          isOpen: _isOpen,
                          prodDesc: _prodDesc,
                          prodName: _prodName
                      )*/
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: _isOpen ? 200 : 80,
                          child: Text(
                            "\$$_price",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF1E80),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      // width: 65,
                      // future: _firebaseServices.servicesRef.doc(document.id).get(),
                      decoration: BoxDecoration(
                        color: _isOpen ? Colors.amberAccent : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // height: _isSelected ? 300 : 55,
                      height: _isOpen ? 200 : 80,
                      // width: double.infinity,
                      alignment: Alignment.center,

                      margin: const EdgeInsets.all(
                        3,
                      ),
                      child: Image (
                        image: _prodImg == "" || _prodImg!.contains('example')
                            ? const AssetImage("assets/images/splashScreenPlaceholder.png") as ImageProvider
                            : NetworkImage("${_prodImg}"),
                        // image: AssetImage("assets/images/splashScreenPlaceholder.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ]
    );
  }
}
