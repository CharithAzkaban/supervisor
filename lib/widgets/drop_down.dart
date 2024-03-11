import 'package:flutter/material.dart';
import 'package:supervisor/utils/consts.dart';

class DropDown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>>? items;
  final String labelText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  const DropDown({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: labelText,
        filled: false,
        fillColor: white,
      ),
    );
  }
}
