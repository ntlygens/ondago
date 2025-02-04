import 'package:flutter/material.dart';

class ProdViewDesc extends StatefulWidget {
  final bool? isOpen;
  final String? prodName;
  final String? prodDesc;
  const ProdViewDesc({super.key,
    this.isOpen,
    this.prodDesc,
    this.prodName
  });

  @override
  State<ProdViewDesc> createState() => _ProdViewDescState();
}

class _ProdViewDescState extends State<ProdViewDesc> {
  late final bool? _isOpen =  widget.isOpen;
  late final String? _prodDesc =  widget.prodDesc;
  late final String? _prodName =  widget.prodName;


  @override
  Widget build(BuildContext context) {
    // Object isOpen = this.isOpen ?? false;
    // return const Placeholder();
    return Container(
      // width: 300,
      decoration: BoxDecoration(
        color: _isOpen! ? Colors.amberAccent : Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      // height: _isSelected ? 300 : 55,
      height: _isOpen! ? 200 : 80,
      alignment: Alignment.topLeft,

      margin: const EdgeInsets.all(
        3,
      ),
      padding: EdgeInsets.fromLTRB(
        8, 6, 8, 8
      ),
      // margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Text(
            "${_prodName}",
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: _isOpen! ? Colors.black12 : Colors.black45,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${_prodDesc}",
            maxLines: 3,
            textAlign: TextAlign.left,
            style: TextStyle(
              height: 1.1,
              color: _isOpen! ? Colors.black12 : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );

  }
}
