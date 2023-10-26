import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/product_viewer.dart';
import 'package:ondago/widgets/action_bar.dart';

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
