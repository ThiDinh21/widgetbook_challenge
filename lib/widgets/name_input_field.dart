import 'package:flutter/material.dart';

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
        labelText: 'John Doe',
      ),
    );
  }
}
