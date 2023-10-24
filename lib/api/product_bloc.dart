import 'bloc.dart';
import 'dart:async';
import 'package:ondago/models/product_seller_model.dart';

/// Fetch data when open app ///
class ProductBloc extends Bloc {
  final productController = StreamController<List<ProductSellerModel>>.broadcast();

  @override
  void dispose() {
    /// used to close stream Or StreamController will cause leak issue ///
    productController.close();
  }

}

ProductBloc productBloc = ProductBloc();