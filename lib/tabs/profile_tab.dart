import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});


  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  late List _srvcDataList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          const Center(
            child: Text("Profile Tab"),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseServices.customerSrvcsRef
                .orderBy("btnOrder", descending: false)
                .snapshots(),
              builder: (context, AsyncSnapshot snapshot ){
                if(snapshot.hasError){
                  return Scaffold(
                    body: Center(
                      child: Text("ProfileTab-CustomerSrvcsRef-DataError: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.active) {
                  if(snapshot.hasData){
                    _srvcDataList = snapshot.data!.docs;
                    print('Profile services length = ${_srvcDataList.length}');
                    // print("profile tab user is: ${_firebasePOsServices.getMerchantID()}");

                    return Container(
                      alignment: Alignment.topCenter,
                      width: screenWidth,
                      height: screenHeight,
                      margin: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                      child: Column(
                        children: [
                          SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.antiAlias,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 400,
                                      childAspectRatio: 2 / 1
                                  ),
                                  itemCount: _srvcDataList.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return GestureDetector(
                                      onTap: (){

                                      },
                                      child: Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(
                                          // 8
                                          vertical: 11,
                                          horizontal: 16,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Stack(
                                          children: [
                                            Text ("${_srvcDataList[index]['name']}"),
                                            Container(
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  "${_srvcDataList[index]['images'][0]}",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ),
                        ],
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
            ),
          ),
          const ActionBar(
            title: "Profile Page",
            // hasTitle: false,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
