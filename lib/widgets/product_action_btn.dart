import 'package:flutter/material.dart';

class ProductActionBtn extends StatelessWidget {
  final Function() onPressed;
  final bool isOpen;
  final String? imagePath;
  final bool? trashBtn;
  final bool? isSpicy;
  final bool? hasDairy;
  final bool? hasNuts;
  final Color iconColor;

  const ProductActionBtn({
    super.key,
    required this.onPressed, required this.iconColor, required this.isOpen,
    this.imagePath, this.isSpicy, this.trashBtn,
    this.hasDairy, this.hasNuts
  });

  @override
  Widget build(BuildContext context) {
    late bool _isOpen = isOpen;
    late Color _iconColor = iconColor;
    late bool _isSpicy = isSpicy ?? false;
    late bool _hasDairy = hasDairy!;
    late bool _hasNuts = hasNuts!;
    late bool _trashBtn = trashBtn!;

    /*Future _setIconColors() async {
      switch(_iconColor) {
        case '_isSpicy':
          _iconColor = Colors.redAccent;
          break;
        case '_hasDairy':
          _iconColor = Colors.black54;
          break;
        case '_hasNuts':
          _iconColor = Colors.brown;
          break;
        default:
          _iconColor = Colors.black;
      }
      // return _iconColor;
    }*/

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _iconColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(
          vertical: _isSpicy ? 12 : 4,
          horizontal: 3,
        ),
        margin: _isOpen ? EdgeInsets.only(bottom: 4) : EdgeInsets.all(2) ,
        child: Image(
          image: AssetImage(imagePath ?? "assets/images/baseline_delete_black_24dp.png"),
          width: _isOpen ? 20 : 12,
          height: _isOpen ? 20 : 12,
          color: _iconColor
        ),
      ),
    );
  }
}
