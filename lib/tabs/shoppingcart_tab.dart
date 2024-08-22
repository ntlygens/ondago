import 'package:flutter/material.dart';
import 'package:ondago/widgets/action_bar.dart';

class ShoppingCartTab extends StatelessWidget {
  const ShoppingCartTab({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Stack(
        children: [
          Center(
            child: Text(
              "Cart Tab"
            ),
          ),
          ActionBar(
            title: "Shopping Cart",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
