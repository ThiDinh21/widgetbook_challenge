import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameInputField extends StatelessWidget {
  /// Creates a new instance of [NameInputField].
  const NameInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Your name',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z- ]')),
      ],
    );
  }
}
