import 'dart:convert';
import 'package:ondago/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ondago/api/product_bloc.dart';
import 'package:ondago/models/product_seller_model.dart';

class ProductSellers extends StatefulWidget {
  final String prodName;
  final String? prodID;

  const ProductSellers({super.key, required this.prodName, this.prodID});

  @override
  _ProductSellersState createState() => _ProductSellersState();
}

class _ProductSellersState extends State<ProductSellers> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  // Future<void> fetchLocalProductSellers() async {
  Future _fetchLocalProductSellers() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Retailers")
        .orderBy("name", descending: true)
        .get()
        .then((_) {
          print("sellers retrieved");
        });

    /*http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final List sList = body["results"];
      allProductSellers = sList.map((model) =>
          ProductSellerModel.fromJson(model)).toList();
      productBloc.productController.sink.add(allProductSellers);
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );*/
  }
  
  @override

  void initState() {
    _fetchLocalProductSellers();
    // fetchRemoteProductSellers();
    super.initState();
  }

  List<ProductSellerModel> allProductSellers = [];

  void productSearch(String searchQuery) {
    List<ProductSellerModel> searchResult = [];

    productBloc.productController.sink.add(searchResult);

    if(searchQuery.isEmpty) {
      productBloc.productController.sink.add(searchResult);
      return;
    }
    for (var seller in allProductSellers) {
      if (seller.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
      seller.sellerID.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(seller);
      }
    }
    productBloc.productController.sink.add(allProductSellers);

  }

  Future<void> fetchRemoteProductSellers() async {
    const url = "";
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final List sList = body["results"];
      allProductSellers = sList.map((model) =>
          ProductSellerModel.fromJson(model)).toList();
      productBloc.productController.sink.add(allProductSellers);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
