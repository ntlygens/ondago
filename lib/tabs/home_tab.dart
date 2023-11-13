import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ondago/screens/selected_service_page.dart';
// import 'package:ondago/screens/retail_client_products_lst.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/app_bar_search.dart';
// import 'package:ondago/screens/search_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  // HomeTab({});
  late List _srvcDataList;
  late String? _hdrBnnrImg;
  late String? _hdrBnnrName;
  late PageController _pageController;
  final int _selectedPage = 0;

  late String? _srvcData = "";
  late String? _srvcDataType = "";
  late final String _srvcData2 = "";
  late final String _srvcData2Type = "";

  var key = GlobalKey();
  Size? redboxSize;

  // var _srvcData;

  Future _getSelectedSrvc<String>() async {
    _firebaseServices.servicesRef
        .get()
        .then((value) => {
          for (DocumentSnapshot ds in value.docs) {
            _srvcData = ds.reference.id,
                }
        }
      /*value.docs
        .forEach((element) {
            var docRef = element['isSelected'];

            if (docRef == true) {
              _srvcData = element.id;
              print("Srvc: [${element['name']}] with Id: [$_srvcData] is Selected");
            } else {
              print("Not textVar exists");
            }

            // docRef.collection('sid');
            // docRef.update({'isSelected': true});

          },*/
        );
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

    return Navigator(
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Home"),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context)
                      .push(
                          MaterialPageRoute(
                            builder: (context) => AppBarSesrch(),
                          )),
                      icon: const Icon(Icons.search)
                  )
                ],
                // toolbarHeight: 100,
                /*hasTitle: true,
              hasBackArrow: true,
              hasHdrImg: true,
              headerImage: _headerImage,*/
              ),
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
                              // print('serviceDataLngth: ${_hdrBnnrName}');
                              return Container(
                                alignment: Alignment.topCenter,
                                width: screenWidth,
                                height: screenHeight,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                                                _hdrBnnrImg = _srvcDataList[index]['images'][0];
                                                _hdrBnnrName = _srvcDataList[index]['name'];
                                                _srvcDataType = _srvcDataList[index]['srvcType'];
                                              });

                                              print("HomeTab-Srvc-Data-Name: ${_srvcDataList[index]['name']} \n");
                                              print("HomeTab-Srvc-Data-ID: ${_srvcDataList[index].id}");
                                              print("data ID: ${_srvcData} and first image: ${_hdrBnnrImg}");
                                              // print("HomeTab-Srvc-Data-Type: ${_srvcDataList[index]['srvcType']}");
                                              Navigator.push(context, MaterialPageRoute(
                                                  maintainState: true,
                                                  builder: (context) =>
                                                  // Text("this is iit")
                                                  SelectedServicePage(
                                                    serviceID: "${_srvcData}",
                                                    serviceType: "${_srvcDataType}",
                                                    headerImg: _hdrBnnrImg,
                                                    headerName: _hdrBnnrName
                                                  )
                                                // RetailClientProductsLst(),
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
                                                  Text ("${_srvcDataList[index]['name']}"),
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

                  /*ActionBar(
                    key: key,
                    title: "Home Page",
                    hasBackArrow: false,
                  ),*/
                ],
              ),

          );
        });
      },

    );
  }

  /// get size of actionBar to drop tab below it ///
  Size getRedBoxSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }
}
