import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/cart_page.dart';
import 'package:ondago/services/firebase_services.dart';

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
  @override
  final Size preferredSize;
  final List<Widget>? actions;

  const ActionBar({
    this.key, this.title, this.hasBackArrow,
    this.hasTitle, this.centerTitle,
    this.hasBackground, this.hasCounter,
    this.hasHdrImg, this.headerImage, this.actions,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

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
    bool hasBackArrow = widget.hasBackArrow ?? false;
    bool hasTitle = widget.hasTitle ?? true;
    bool hasBackground = widget.hasBackground ?? false;
    bool hasCounter = widget.hasCounter ?? true;
    bool hasHdrImg = widget.hasHdrImg ?? false;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // print("headerImg first img: ${widget.headerImage}");

    return Container(
      alignment: Alignment.topCenter,
      width: screenWidth,
      // height: 120,
      margin: EdgeInsets.only(
        top: hasHdrImg ? 0 : 0,
        left: hasHdrImg ? 0 : 0,
        right: hasHdrImg ? 0 : 0,
        bottom: hasHdrImg ? 0 : 0
      ),
      decoration: BoxDecoration(
        gradient: hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.blueGrey.withOpacity(0.5),
          ],
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1)
        ) : null
      ),
      padding: EdgeInsets.only(
        top: hasHdrImg ? 0 : 0,
        left: hasHdrImg ? 0 : 0,
        right: hasHdrImg ? 0 : 0,
        bottom: hasHdrImg ? 0 : 0
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
            mainAxisAlignment: !hasBackArrow ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              if (hasBackArrow)
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
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

              if ( hasTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    widget.title ?? "Title here",
                    style: Constants.boldHeadingW, textAlign: TextAlign.center,
                  ),
                ),

              if (hasCounter)
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
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
