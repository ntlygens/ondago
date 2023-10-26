import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/product_viewer.dart';
import 'package:ondago/widgets/action_bar.dart';

class RetailClientProductsLst extends StatefulWidget {
  final Function? onPressed;
  RetailClientProductsLst({super.key,  this.onPressed});

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
                .orderBy("name", descending: true)
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
                    // print("prodID: ${prodData[0]['name']}");
                    // Collect Selected docs into array / ListView
                    // display data in listview
                    return ListView.builder (
                      itemCount: _prodData.length,
                        itemBuilder: (BuildContext context, int index) {
                        print("client product name = ${_prodData[index]['name']}");
                          return Container(
                              /*padding : EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),*/
                              // children: [
                              // children: _prodData.map((prodData, index) =>
                              ///// for (var i = 0; i < _prodData.length; i++)
                                // seperate array into individual documents
                            child: Text(
                              "thisiis retail client product list page"
                            ),

                              /*child: ProductViewer(
                                  isSelected: index == 0,
                                  prodID: prodData[index]['prodID'],
                                  prodName: prodData[index]['prodName'],
                                  prodSrvcID: prodData[index]['srvcCtgryID'],
                                  prodSrvcName: prodData[index]['srvcCtgry'],
                                  // prodSellers: [''],
                                  srvcProdID: prodData[index].id,
                                )*/
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
