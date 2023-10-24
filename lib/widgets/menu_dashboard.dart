import 'package:flutter/material.dart';
import 'package:ondago/services/firebase_services.dart';


class MenuDashboard extends StatefulWidget {
  final String menuID;
  final List? menuItemsAll;
  const MenuDashboard ({
    required this.menuID,
    this.menuItemsAll,
  });
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>{
  final FirebaseServices _firebaseServices = FirebaseServices();

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

    // TODO: implement build
    throw UnimplementedError();
  }
}