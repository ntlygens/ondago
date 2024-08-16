
import 'package:flutter/material.dart';
import 'package:ondago/screens/selected_service_page.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/custom_btn.dart';
import 'package:ondago/widgets/prod_n_price.dart';
import 'package:ondago/widgets/product_wndw.dart';

class ProductViewer extends StatefulWidget {
  final String? prodPID;
  final String? prodName;
  final num? prodPrice;
  final String? prodSrvcName;
  final String? prodSrvcID;
  final String? prodSrvcType;
  final String srvcProdID;
  final bool? isSelected;
  final List? prodSellers;
  const ProductViewer({
    this.prodPID,
    this.isSelected,
    this.prodName,
    this.prodPrice,
    this.prodSrvcName,
    this.prodSrvcID,
    this.prodSrvcType,
    required this.srvcProdID,
    this.prodSellers
  });

  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  Future _removeServiceProduct(value) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
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
        .collection("SelectedService")
        .orderBy("date", descending: true)
        .get()
        .then((_) {
          print("list refreshed");
        });

  }

  Future _getProductSellers() async {
    return _firebaseServices.productsRef
        .doc(widget.prodPID)
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
    bool isSelected = widget.isSelected ?? false;
    return Stack(
      children: [
        if(isSelected)
          Card(
            child: Stack(
              children: [
                /*ProdNPrice(
                  prodName: "${widget.prodName}",
                  altProds: const ['tea', 'eel', 'urchin'],
                ),*/

                /// selected product NAME
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top: BorderSide(color: Colors.green),
                      bottom: BorderSide(color: Colors.green),
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 100,
                      right: 48,
                      bottom: 10,
                      left: 48
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${widget.prodName}",
                    style: const TextStyle(
                        fontSize: 28,
                    ),
                  ),
                ),

                /// lowest product PRICE
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      // top: BorderSide(color: Colors.green),
                      // bottom: BorderSide(color: Colors.green),
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 10,
                      right: 110,
                      bottom: 0,
                      left: 110
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "~~   \$12.90   ~~",
                    // "${widget.prodName}",
                    style: TextStyle(
                        fontSize: 22,
                      color: Color(0xFFFF1E80),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),

                /// seller GRID
                /*Container(
                  // height: 400,
                  // margin: EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder(
                    // future: _getProductSellers(),
                    stream:_firebaseServices.productsRef
                    .doc(widget.prodPID)
                    .snapshots(),
                    builder: (context, AsyncSnapshot prodSellerSnap) {
                      if (prodSellerSnap.hasError){
                        return Container(
                          child: Text("ERROR: ${prodSellerSnap.error}"),
                        );
                      }

                      if(prodSellerSnap.connectionState == ConnectionState.active) {
                        if(prodSellerSnap.hasData) {
                          List sellerData = prodSellerSnap.data!['seller'];
                          // var _sellerData = prodSellerSnap.data!['desc'];
                          // print ("${prodSellerSnap.data!['seller']} is the srvc");
                          // print("product: ${prodSellerSnap.data!['name']}");
                          print("sellers: $sellerData");

                          return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 1 / 1,
                                  // mainAxisSpacing: 0
                              ),
                              itemCount: sellerData.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return StreamBuilder(
                                  stream: _firebaseServices.sellersRef
                                      .doc("${sellerData[index]}")
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot sellerSnap) {

                                    if(sellerSnap.connectionState == ConnectionState.active) {
                                      if(sellerSnap.hasData) {
                                        // print("ID: ${sellerSnap.data.id} \n Name: ${sellerSnap.data['name']}");
                                        return ProductWndw(
                                          sellerID: "${sellerSnap.data['sellerID']}",
                                          sellerName: "${sellerSnap.data['name']}",
                                          sellerLogo: "${sellerSnap.data['logo']}",
                                          prodQty: "${sellerSnap.data['inStockQty']}",
                                          prodID: "${widget.prodPID}",
                                          prodName: "${widget.prodName}",
                                          isSelected: sellerSnap.data['hasItem'],
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
                              }
                          );

                        }

                      }
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),*/

                /// return to service BUTTON
                /*GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          const Text("this is it")
                          SelectedServicePage(
                          serviceID: "${widget.prodSrvcID}",
                        )
                      )
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amberAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: isSelected ? 55 : 45,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 28,
                      bottom: 40,
                      left: 28,
                    ),
                    child: Text(
                      "${widget.prodSrvcName}",
                      style: TextStyle(
                        color: isSelected ? Colors.black54 : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ),*/

                /// recently viewed BANNER
                /*Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top: BorderSide(color: Colors.green),
                      bottom: BorderSide(color: Colors.green),
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 30,
                    right: 12,
                    bottom: 18,
                    left: 12
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Recently Viewed',
                    style: TextStyle(fontSize: 16),
                  ),
                ),*/
              ]
            ),
          )
        else
          Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = true;
                  print("selected");
                });

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        // const Text("this is it"),
                        SelectedServicePage(
                          serviceID: "${widget.prodSrvcID}",
                          serviceType: "${widget.prodSrvcType}",
                        )
                ));

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      // width: 300,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amberAccent : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // height: _isSelected ? 300 : 55,
                      height: isSelected ? 350 : 65,
                      alignment: Alignment.center,

                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 8,
                        bottom: 10,
                        left: 8,
                      ),
                      child: Text(
                        "${widget.prodName}",
                        style: TextStyle(
                            color: isSelected ? Colors.black12 : Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      // padding: const EdgeInsets.symmetric(vertical: 10),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.amberAccent : Colors.black12,
                            // border: Border.all(
                            //     color: Colors.black45,
                            //     width: 1,
                            //     style: BorderStyle.solid
                            // ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            // ~~   \$12.90   ~~",
                            "inCart",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              letterSpacing: 1.0,

                            ),
                          ),
                        ),
                        Text(
                          // ~~   \$12.90   ~~",
                          "${widget.prodPrice}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFFFF1E80),
                            letterSpacing: 1.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // width: 65,
                      // future: _firebaseServices.servicesRef.doc(document.id).get(),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amberAccent : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // height: _isSelected ? 300 : 55,
                      height: isSelected ? 350 : 65,
                      // width: double.infinity,
                      alignment: Alignment.center,

                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 8,
                        bottom: 10,
                        left: 8,
                      ),
                      child: Image (
                        image: AssetImage("assets/images/italFusionLogo.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

      ],
    );
  }
}
