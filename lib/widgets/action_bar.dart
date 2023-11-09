import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/cart_page.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/image_swipe.dart';

class ActionBar extends StatefulWidget {
  @override
  final GlobalKey? key;
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasBackground;
  final bool? hasHdrImg;
  final String? headerImage;

  ActionBar({ this.key, this.title, this.hasBackArrow, this.hasTitle, this.hasBackground, this.hasHdrImg, this.headerImage });

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow ?? false;
    bool _hasTitle = widget.hasTitle ?? true;
    bool _hasBackground = widget.hasBackground ?? true;
    bool _hasHdrImg = widget.hasHdrImg ?? false;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    print("headerImg first img: ${widget.headerImage}");

    return Container(
      alignment: Alignment.topCenter,
      width: screenWidth,
      height: _hasHdrImg ? 150 : 100,
      margin: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        /*gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.yellow,
            Colors.green.withOpacity(0.5),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1)
        ) : null*/
      ),
      padding: EdgeInsets.only(
        top: _hasHdrImg ? 0 : 40,
        left: _hasHdrImg ? 0 : 24,
        right: _hasHdrImg ? 0 : 24,
        bottom: _hasHdrImg ? 0 : 0
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          if (widget.hasHdrImg == true)
            SizedBox(
              width: screenWidth,
                child: Image.network(
                    "${widget.headerImage}",
                  fit: BoxFit.fill,
                ),
            ),
          Row(
            mainAxisAlignment: _hasHdrImg ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
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
                  widget.title ?? "Title here",
                  style: Constants.boldHeadingW,
                )
              else
                Text(
                  widget.title ?? "Title here",
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
        ],
      ),
    );
  }
}
