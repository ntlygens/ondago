import 'package:flutter/material.dart';
import 'package:ondago/widgets/action_bar.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          const Center(
            child: Text("Products Tab"),
          ),
          ActionBar(
            title: "Products Page",
            hasTitle: false,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
