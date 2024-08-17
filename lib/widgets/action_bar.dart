import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/cart_page.dart';
import 'package:ondago/services/firebase_services.dart';
import 'package:ondago/widgets/image_swipe.dart';

class ActionBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final GlobalKey? key;
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? centerTitle;
  final bool? hasBackground;
  final bool? hasHdrImg;
  final bool? hasCounter;
  final String? headerImage;
  final Size preferredSize;
  final List<Widget>? actions;

  ActionBar({
    this.key, this.title, this.hasBackArrow,
    this.hasTitle, this.centerTitle,
    this.hasBackground, this.hasCounter,
    this.hasHdrImg, this.headerImage, this.actions,
  }) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  State<ActionBar> createState() => _ActionBarState();

  // @override
  // TODO: implement preferredSize
  // Size get preferredSize => throw UnimplementedError();
}

class _ActionBarState extends State<ActionBar> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow ?? false;
    bool _hasTitle = widget.hasTitle ?? true;
    bool _hasBackground = widget.hasBackground ?? false;
    bool _hasCounter = widget.hasCounter ?? true;
    bool _hasHdrImg = widget.hasHdrImg ?? false;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // print("headerImg first img: ${widget.headerImage}");

    return Container(
      alignment: Alignment.topCenter,
      width: screenWidth,
      // height: 120,
      margin: EdgeInsets.only(
        top: _hasHdrImg ? 0 : 0,
        left: _hasHdrImg ? 0 : 0,
        right: _hasHdrImg ? 0 : 0,
        bottom: _hasHdrImg ? 0 : 0
      ),
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.blueGrey.withOpacity(0.5),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1)
        ) : null
      ),
      padding: EdgeInsets.only(
        top: _hasHdrImg ? 0 : 0,
        left: _hasHdrImg ? 0 : 0,
        right: _hasHdrImg ? 0 : 0,
        bottom: _hasHdrImg ? 0 : 0
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
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
            mainAxisAlignment: !_hasBackArrow ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              if (_hasBackArrow)
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: const Image(
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        image: AssetImage(
                            "assets/images/back_arrow.png"
                        ),
                      ),
                    ),
                  ),
                ),

              if ( _hasTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    widget.title ?? "Title here",
                    style: Constants.boldHeadingW, textAlign: TextAlign.center,
                  ),
                ),

              if (_hasCounter)
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),

                            );
                          }
                      ),
                    ),
                  ),
                )


              // if (_hasTitle && _hasBackArrow)

              // else
              //   Text(
              //     widget.title ?? "Title here",
              //     style: Constants.boldHeading,
              //   ),



            ],
          ),
        ],
      ),
    );
  }
}
