import 'package:flutter/material.dart';

class TFF extends StatelessWidget {
  String? hintText;
  String? labelText;
  IconData? prefixIcon;
  Color? prefixIconColor;
  Widget? suffixIcon;
  bool obscureText;
  TextEditingController controller;
  void Function(String)? onChanged;
  void Function()? onPressed;

  TFF({super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    required this.obscureText,
    required this.controller,
    this.onPressed,
    this.onChanged
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: (value)
      {
        if(value!.isEmpty)
          {
            return 'This Field is required';
          }
      },
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(prefixIcon,color: prefixIconColor,),
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
      ),
    );
  }
}
