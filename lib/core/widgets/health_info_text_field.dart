import 'package:flutter/material.dart';

class HealthInfoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final bool readOnly;
  final int maxLines;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const HealthInfoTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
        validator: validator,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon:
          prefixIcon != null ? Icon(prefixIcon) : null,
          border: const OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}