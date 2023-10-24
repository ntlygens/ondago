import 'package:flutter/material.dart';
import 'package:ondago/screens/search_page.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  // SearchTab({});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchPage(),
      /*child: Stack(
        children: [
          Center(
            child: Text("Search Tab"),
          ),
          ActionBar(
            title: "Search Page",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),*/
    );
  }
}
