import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ondago/screens/selected_service_page.dart';
// import 'package:ondago/screens/service_products_page.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/action_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  // HomeTab({});
  late List _srvcDataList;
  late PageController _pageController;
  final int _selectedPage = 0;

  late String? _srvcData = "";
  late String? _srvcDataType = "";
  late final String _srvcData2 = "";
  late final String _srvcData2Type = "";

  var key = GlobalKey();
  Size? redboxSize;

  // var _srvcData;
  /*Future _dsplySrvc(value) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .doc(value)
        .delete()
        .then((_) {
          print("product ${value} removed");
          // _refreshServiceProduct();
        });
  }*/

  /*Future _getOtherDB<String>() async {
    var _othrDB = _firebaseServices.servicesRefPOS
        .get()
        .then((value) => value.docs
          .forEach((element) {
            // var docRef = _firebaseServices.servicesRef
            //   .doc(element.id).snapshots();
            var docRef = element['isSelected'];

            if (docRef == true) {
              _srvcData2 = element.id;
              print("${_srvcData2} is Selected");
            } else {
              print("Not textVar2 exists");
            }
          })
        );
    print("thi is 2: ${_othrDB}");
    return _srvcData2;
    // docRef.collection('sid');
    // docRef.update({'isSelected': true});
  }*/

  Future _getSelectedSrvc<String>() async {
    var myVar = _firebaseServices.servicesRef
    // var _myVar = _firebaseServices.servicesRefPOS
        .get()
        .then((value) => value.docs
        .forEach((element) {
            // var docRef = _firebaseServices.servicesRef
            //   .doc(element.id).snapshots();
            var docRef = element['isSelected'];

            if (docRef == true) {
              _srvcData = element.id;
              print("Srvc: [${element['name']}] with Id: [$_srvcData] is Selected");
            } /*else {
              print("Not textVar exists");
            }*/

            // docRef.collection('sid');
            // docRef.update({'isSelected': true});

          },
        ))

        // .get();
        // .then((value) => value['type']);
        // .toString()
    ;

    // print("thi is: ${_srvcData}");
    return _srvcData;
  }

  Future _dsplySelectedSrvc(value) async {
    return _firebaseServices.servicesRef
    // return _firebaseServices.servicesRefPOS
        .get()
        .then((value) => value.docs
          .forEach((element) {
            var docRef = _firebaseServices.servicesRef
            // var docRef = _firebaseServices.servicesRefPOS
                .doc(element.id);

                docRef.update({'isSelected': true});
            },
          ),
        );
  }

  @override
  void initState() {
    _pageController = PageController();
    _getSelectedSrvc();
    // _srvcData = "AnnNjTT8vmYSAEpT0rPg";
    /// for use with ondago-pos db ///
    /// _srvcData = "VnhXnkWdbvbZcSm7duYF"; ///
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        redboxSize = getRedBoxSize(key.currentContext!);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double actnBarHeight = MediaQuery.of(context).this<ActionBar>.size.height;
    // _getSelectedSrvc();
   //  _getOtherDB();
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text("Home Tab"),
          ),
          Padding(
            padding: const EdgeInsets.all(
                0
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: _firebaseServices.servicesRef
                // stream: _firebaseServices.servicesRefPOS
                    .orderBy("btnOrder", descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if( snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("HomeTab-SrvcsRef-DataError: ${snapshot.error}"),
                      ),
                    );
                  }

                  if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData){
                      _srvcDataList = snapshot.data!.docs;
                      // print('serviceDataLngth: ${_srvcDataList.length}');
                      return Container(
                        alignment: Alignment.topCenter,
                        width: screenWidth,
                        height: screenHeight,
                        margin: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                        padding: const EdgeInsets.symmetric (
                            vertical: 0,
                            horizontal: 0
                          // 8,
                          // vertical: 16,
                          // horizontal: 8
                        ),
                        decoration: const BoxDecoration(
                          // color: Color(0xB3EFBCBC),
                          // borderRadius: BorderRadius.circular(8)
                        ),

                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        child: SizedBox(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                clipBehavior: Clip.antiAlias,
                                // physics: ScrollPhysics(),
                                child: GridView.builder(
                                  // padding: EdgeInsets.fromLTRB(0, 70, 0, 320),
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 400,
                                      childAspectRatio: 2 / 1
                                  ),
                                  itemCount: _srvcDataList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _srvcData = _srvcDataList[index].id;
                                          _srvcDataType = _srvcDataList[index]['srvcType'];
                                        });

                                        print("HomeTab-Srvc-Data-Name: ${_srvcDataList[index]['name']} \n");
                                        print("HomeTab-Srvc-Data-ID: ${_srvcDataList[index].id}");
                                        // print("HomeTab-Srvc-Data-Type: ${_srvcDataList[index]['srvcType']}");
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                const Text("this is iit")
                                                /*SelectedServicePage(
                                                  serviceID: "${_srvcData}",
                                                  serviceType: "${_srvcDataType}",
                                                )*/
                                          // ServiceProductsPage(),
                                        ));
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
                                                /*child: Text(
                                                  "${_srvcDataList[index]['name']}"
                                                ),*/
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
                                  },
                                ),
                              )

                          ),
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
          ),

          // FutureBuilder<QuerySnapshot>(

          ActionBar(
            key: key,
            title: "Home Page",
            hasBackArrow: false,
          ),
        ],
      ),

    );
  }

  /// get size of actionBar to drop tab below it ///
  Size getRedBoxSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }
}
