import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  const PrimaryTextfield(
      {Key? key,
      this.controller,
      this.labelText,
      this.hintText,
      this.helperText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.obscureText,
      this.validator,
      this.onChanged})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText, hintText, helperText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(
            color: Color(0xffFDB415), fontWeight: FontWeight.w600),
        errorStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
            fontWeight: FontWeight.w600),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100.0),
            ),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
      ),
      keyboardType: keyboardType,
    );
  }
}
