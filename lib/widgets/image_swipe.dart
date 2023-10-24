import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  const ImageSwipe({ required this.imageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 150,
      margin: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
              children: [
                for(var i = 0; i < widget.imageList.length; i++)
                  Container(
                      child: Image.network(
                        "${widget.imageList[i]}",
                        fit: BoxFit.cover,
                      )
                  )
              ]

          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6
                    ),
                    width: _selectedPage == i ? 36 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)
                    ),

                  )
              ],

            ),
          )
        ],

      ),
    );
  }
}
