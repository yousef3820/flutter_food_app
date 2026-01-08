import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.isPassword,
    required this.valdatorFunction,
    required this.prefixIcon,
    this.onsavedFunction,
    this.onchangedFunction,
  });
  final String hintText;
  final TextInputType inputType;
  final bool isPassword;
  final IconData prefixIcon;
  final String? Function(String? value)? valdatorFunction;
  final void Function(String? value)? onsavedFunction;
  final void Function(String? value)? onchangedFunction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.valdatorFunction,
      onSaved: widget.onsavedFunction,
      obscureText: _isObscured,
      keyboardType: widget.inputType,
      onChanged: widget.onchangedFunction,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: MainColors.mainColor,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: MainColors.mainColor,
                ),

                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: widget.hintText,
        floatingLabelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(
          color: const Color(0xFFFFCAC7),
          fontSize: 13,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
