import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;

  CustomDropdownFormField({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff181818).withOpacity(0.5), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff181818).withOpacity(0.5), width: 1.0),
          ),
        ),
        value: widget.selectedValue,
        onChanged: widget.onChanged,
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: CustomColorTheme.iconColor,
        ),
      ),
    );
  }
}
