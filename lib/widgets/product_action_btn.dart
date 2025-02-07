import 'package:flutter/material.dart';

class ProductActionBtn extends StatelessWidget {
  final bool isSelected;
  final bool prodActnBtn;
  final Function() onPressed;

  final String? imagePath;
  final bool? trashBtn;
  final bool? isSpicy;
  final bool? hasDairy;
  final bool? hasNuts;

  const ProductActionBtn({
    super.key, required this.prodActnBtn,
    required this.isSelected, required this.onPressed,
    this.imagePath, this.isSpicy, this.trashBtn,
    this.hasDairy, this.hasNuts
  });

  @override
  Widget build(BuildContext context) {
    late final bool _isSelected = isSelected;
    late final bool _prodActnBtn = prodActnBtn;
    late final bool _selected = isSelected;
    late final bool _trashBtn = trashBtn!;
    late final bool _isSpicy = isSpicy!;
    late final bool _hasDairy = hasDairy!;
    late final bool _hasNuts = hasNuts!;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(
          vertical: _prodActnBtn ? 4 : 28,
          horizontal: _prodActnBtn ? 3 : 16,
        ),
        margin: _prodActnBtn ? EdgeInsets.only(bottom: 4) : EdgeInsets.all(0),
        child: Image(
          // image: AssetImage(imagePath ?? "assets/images/baseline_home_black_24dp.png"),
          image: AssetImage(
              _prodActnBtn
                  ? ( _selected ? imagePath! : "" )
                  : ( imagePath! )
          ),
          width: _prodActnBtn ? 20 : 24,
          height: _prodActnBtn ? 20 :24,
          color: _prodActnBtn
              ? _selected ? Theme.of(context).colorScheme.primary : Colors.transparent
              : _selected ? Theme.of(context).colorScheme.primary : Colors.black87 ,
        ),
      ),
    );
  }
}
