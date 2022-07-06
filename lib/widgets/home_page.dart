import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/widgets/name_input_field.dart';

class HomePage extends StatelessWidget {
  /// Creates a new instance of [HomePage].
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            NameInputField(
              controller: TextEditingController(),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
