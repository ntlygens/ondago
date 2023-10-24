import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/product_viewer.dart';
import 'package:ondago/widgets/action_bar.dart';

class ServiceProductsPage extends StatefulWidget {
  final Function? onPressed;
  final bool isCstmrSrvc;
  const ServiceProductsPage({ this.onPressed, required this.isCstmrSrvc});

  @override
  _ServiceProductsPageState createState() => _ServiceProductsPageState();
}

class _ServiceProductsPageState extends State<ServiceProductsPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            // get all selected documents from SelectedService
            stream: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserID())
                .collection("SelectedService")
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if( snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("ServiceProductPageError: ${snapshot.error}"),
                  ),
                );
              }

              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData){
                    List prodData = snapshot.data.docs;
                    // print("prodID: ${_prodData[0].id}");
                    // Collect Selected docs into array / ListView
                    // display data in listview
                    return ListView.builder (
                      itemCount: prodData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              /*padding : EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),*/
                              // children: [
                              // children: _prodData.map((prodData, index) =>
                              ///// for (var i = 0; i < _prodData.length; i++)
                                // seperate array into individual documents
                              child: ProductViewer(
                                  isSelected: index == 0,
                                  prodID: prodData[index]['prodID'],
                                  prodName: prodData[index]['prodName'],
                                  prodSrvcID: prodData[index]['srvcCtgryID'],
                                  prodSrvcName: prodData[index]['srvcCtgry'],
                                  // prodSellers: [''],
                                  srvcProdID: prodData[index].id,
                                )
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
