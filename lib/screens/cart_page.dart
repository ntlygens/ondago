import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';
import 'selected_service_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});



  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          FutureBuilder(
            future: _firebaseServices.usersRef.doc(
              _firebaseServices.getUserID()
            ).collection("Cart").get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // collection data to display
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasData) {
                  // display data in listview
                  return ListView(
                    // shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 120,
                      bottom: 24,
                    ),
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                SelectedServicePage(
                                  serviceID: document.id,
                                  serviceType: document['srvcType'],
                                ),
                          ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.servicesRef.doc(document.id)
                              .get(),
                          builder: (context, AsyncSnapshot serviceSnap) {
                            if (serviceSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text(
                                      "${serviceSnap.error}"
                                  ),
                                ),
                              );
                            }

                            if (serviceSnap.connectionState ==
                                ConnectionState.done) {
                              if(serviceSnap.hasData) {
                                Map serviceMap = serviceSnap.data!.data();

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // height: 225,
                                  // width: double.infinity,
                                  // alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 14,
                                  ),
                                  child: Container(
                                    child: Text("${serviceMap['name']}"),
                                  ),

                                  /*Stack(
                              children: [
                                Container(
                                  // padding: EdgeInsets.only(
                                  //   bottom: 24
                                  // ),
                                  // height: 210,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text(
                                      "${document.data()['type']}",

                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 20,
                                  right: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        document.data()['name'] ?? "Product Name",
                                        style: Constants.regHeading,
                                      ),
                                      Text(
                                        // for price use statement below for added
                                        // dollar sign to register.
                                        // "\$${document.data()['price']}"
                                        document.data()['type'][0] ?? "Price",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),*/
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


                      );
                    }).toList(),
                  );
                }
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            },
          ),
          const ActionBar(
            hasBackArrow: true,
            title: "Cart",
          )
        ],
      )
    );
  }
}
