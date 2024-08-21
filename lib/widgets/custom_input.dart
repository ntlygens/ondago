import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;

  const CustomInput({super.key,  this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          )
        ),
        style: Constants.regDarkTxt,
      ),
    );
  }
}
