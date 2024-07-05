import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(), // Add a border
        suffixIcon: this.maxLines == 1 // Add clear button for single-line fields
            ? IconButton(
          onPressed: () => onSaved!(null),
          icon: Icon(Icons.clear),
        )
            : null,
      ),
      maxLines: maxLines,
      onSaved: onSaved,
      validator: validator,
    );
  }
}