import 'package:flutter/material.dart';

class CustomAuthTextField extends StatefulWidget {
  const CustomAuthTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    this.textInputType = TextInputType.text,
    this.isPasswordField = false,
  });

  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String label;
  final bool isPasswordField;
  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.textEditingController,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
          label: Text(widget.label),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isPasswordVisible = !isPasswordVisible;
                      },
                    );
                  },
                  icon: isPasswordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : null),
      obscureText: widget.isPasswordField ? !isPasswordVisible : false,
    );
  }
}
