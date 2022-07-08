import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An input text field that only accept characters from a to z, A to Z,
/// dashes("-") and spaces(" ")
class NameInputField extends StatelessWidget {
  /// Creates a new instance of [NameInputField].
  const NameInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  /// Controller to access and modify the text field from parent widgets
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Your name',
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: const Icon(Icons.clear),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z- ]')),
      ],
    );
  }
}
