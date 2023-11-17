import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ondago/constants.dart';
import 'dart:ffi';

class RetailClientCard extends StatelessWidget{
  // final List imageList;
  final String retailClientBnr;
  final String retailClientName;
  final String retailClientRating;
  final List retailClientSrvcs;
  final List retailClientStatus;
  const RetailClientCard({
    // required this.imageList,
    required this.retailClientBnr,
    required this.retailClientName,
    required this.retailClientRating,
    required this.retailClientSrvcs,
    required this.retailClientStatus
  });

  @override
  Widget build(BuildContext context) {
    late String _retailClientBnr = retailClientBnr;
    late String _retailClientName = retailClientName;
    late String _retailClientRating = retailClientRating;
    late List _retailClientSrvcs = retailClientSrvcs;
    late List _retailClientStatus = retailClientStatus;

    // double rcStatW = (40 * _retailClientStatus.length);
    // print("object: ${_retailClientStatus}");
    // TODO: implement build
    return Stack(
      // alignment: Alignment.topLeft,
      fit: StackFit.loose,
      children: [
        /// *** Background container *** ///
        Container(
          height: 100,
          // color: Colors.amber,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
                width: 1,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent, spreadRadius: 0
              )
            ],
          ),
        ),
        /// *** Services container *** ///
        Positioned(
          left: 20,
          top: 44,
          width: 92,
          height: 92,
          child: Container(
            padding: EdgeInsets.all(6),
            // color: Colors.lightGreenAccent,
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              border: Border.all(
                color: Colors.black54,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignOutside
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.45),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(-1, 0), // changes position of shadow
                ),
                // BoxShadow(color: Colors.deepOrange, spreadRadius: 3),
              ],
            ),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 40,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6
                ),
                itemCount: _retailClientSrvcs.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    // width: 30,
                    // height: 30,
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside
                        ),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Stack(
                        children: [
                          // Solid text as fill.
                          _retailClientSrvcs[index],
                        ]
                    ),
                  );
                }
            ),
          ),
        ),
        /// *** Image container *** ///
        Positioned(
          right: 20,
          top: 31,
          height: 120,
          child:
            Container(
              margin: EdgeInsets.fromLTRB(
                0, 0, 0, 0
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.deepOrange,
                    width: 3,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignCenter
                ),
                borderRadius: BorderRadius.circular(6),
                // color: Colors.deepOrange,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.45),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                  // BoxShadow(color: Colors.deepOrange, sprea`dRadius: 3),
                ],
              ),
              child: Image.network(
                "${_retailClientBnr}",
                fit: BoxFit.contain,
            ),
          ),
        ),
        /// *** Name container *** ///
        Positioned(
          right: 40,
          top: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8
            ),
            child: Text (
              "${_retailClientName}".toUpperCase(),
              style: Constants.allCapsHeadingW,
            ),
          ),
        ),
        /// *** Rating container *** ///
        Positioned(
          left: 8,
          top: 8,
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            // margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside
              ),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Stack(
              children: [
                Text(
                  "${_retailClientRating}",
                  style: TextStyle(
                    fontSize: 21,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.blue[700]!,
                  ),
                ),
                // Solid text as fill.
                Text(
                  "${_retailClientRating}",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.deepOrangeAccent,
                    // color: Colors.lime[400],
                  ),
                ),
              ]
            ),
          ),
        ),
        /// *** Cuisine container *** ///
        Positioned(
          right: 32,
          bottom: 12,
          width: 40,
          height: 40,
          child: Container(
            padding: EdgeInsets.all(4),
            // color: Colors.lightGreenAccent,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Colors.black54,
                  width: 1,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.45),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
                // BoxShadow(color: Colors.deepOrange, spreadRadius: 3),
              ],
            ),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 40,
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6
                ),
                itemCount: _retailClientStatus.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    // width: 30,
                    // height: 30,
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(
                            color: Colors.black54,
                            width: 1,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside
                        ),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Stack(
                        children: [
                          // Solid text as fill.
                          _retailClientStatus[0],
                        ]
                    ),
                  );
                }
            ),
          ),
        ),
      ],

    );
  }
}
