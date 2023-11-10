import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ondago/constants.dart';

class RetailClientCard extends StatelessWidget{
  // final List imageList;
  final String retailClientBnr;
  final String retailClientName;
  final String retailClientRating;
  const RetailClientCard({
    // required this.imageList,
    required this.retailClientBnr,
    required this.retailClientName,
    required this.retailClientRating
  });

  @override
  Widget build(BuildContext context) {
    late String _retailClientBnr = retailClientBnr;
    late String _retailClientName = retailClientName;
    late String _retailClientRating = retailClientRating;
    // TODO: implement build
    return Stack(
      // alignment: Alignment.topLeft,
      fit: StackFit.loose,
      children: [
        Container(
          height: 100,
          // color: Colors.amber,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.amberAccent, spreadRadius: 3
              )
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: 43,
          width: 200,
          height: 92,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            clipBehavior: Clip.antiAlias,
            child: Container(
              color: Colors.green,
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 30,
          height: 120,
          child:
            Container(
              margin: EdgeInsets.fromLTRB(
                0, 0, 0, 0
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.green, spreadRadius: 3),
                ],
              ),
              child: Image.network(
                "${_retailClientBnr}",
                fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: 2,
          top: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8
            ),
            child: Text (
              "${_retailClientName}",
              style: Constants.regHeading,
            ),
          ),
        ),
        Text ("${_retailClientRating}"),
      ],

    );
  }
}
