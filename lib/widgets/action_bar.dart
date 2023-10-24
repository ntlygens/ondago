import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/cart_page.dart';
import 'package:ondago/services/firebase_services.dart';

class ActionBar extends StatelessWidget {
  @override
  final GlobalKey? key;
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasBackground;

  ActionBar({ this.key, this.title, this.hasBackArrow, this.hasTitle, this.hasBackground });
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: const BoxDecoration(
        // gradient: _hasBackground ? LinearGradient(
        //   colors: [
        //     Colors.white,
        //     Colors.white.withOpacity(0),
        //   ],
        //   begin: Alignment(0, 0),
        //   end: Alignment(0, 1)
        // ) : null
      ),
      padding: const EdgeInsets.only(
        top: 40,
        left: 24,
        right: 24,
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Image(
                    image: AssetImage(
                        "assets/images/back_arrow.png"
                    ),
                  ),
              ),
            ),
          if (_hasTitle && _hasBackArrow)
            Text(
              title ?? "Title here",
              style: Constants.boldHeadingW,
            )
          else
            Text(
              title ?? "Title here",
              style: Constants.boldHeading,
            ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(),
                  ));
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8)
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection("Cart").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  int totalItems = 0;

                  if( snapshot.connectionState == ConnectionState.active ) {
                    if(snapshot.hasData) {
                        List documents = snapshot.data!.docs;
                        totalItems = documents.length;
                      }
                    }

                  return Text(
                    "$totalItems",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),

                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }
}
