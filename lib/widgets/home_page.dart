import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_challenge/providers/providers.dart';
import 'package:widgetbook_challenge/widgets/name_input_field.dart';

class HomePage extends ConsumerWidget {
  /// Creates a new instance of [HomePage].
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiState = ref.watch(apiProvider);

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
              onPressed: () {
                ref.read(apiProvider.notifier).submitUsername('Lmao XD');
              },
              child: const Text('Submit'),
            ),
            apiState.map(
              initial: (_) => const SizedBox(),
              loading: (_) => const CircularProgressIndicator(),
              success: (state) => Text(state.msg),
              error: (state) => Text(state.errorMsg),
            ),
          ],
        ),
      ),
    );
  }
}
