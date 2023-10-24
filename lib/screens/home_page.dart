import 'package:flutter/material.dart';
import 'package:ondago/tabs/home_tab.dart';
import 'package:ondago/tabs/profile_tab.dart';
import 'package:ondago/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: const [
                  HomeTab(),
                  ProfileTab(),
                  // SearchTab(),
                  // ShoppingCartTab(),
                ],
              ),
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabClicked: (num) {
              _tabsPageController.animateToPage(
                  num,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic
              );
            },
          ),

        ],
      ),

    );
  }
}
