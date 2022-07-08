import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_challenge/providers/providers.dart';
import 'package:widgetbook_challenge/widgets/name_input_field.dart';

class HomePage extends ConsumerStatefulWidget {
  /// Creates a new instance of [HomePage].
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiState = ref.watch(greetingApiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            NameInputField(
              controller: _controller,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(greetingApiProvider.notifier)
                    .submitUsername(_controller.text.trim());
              },
              child: const Text('Submit'),
            ),
            apiState.map(
              initial: (_) => const SizedBox(),
              loading: (_) => const CircularProgressIndicator(),
              success: (state) {
                _controller.clear();
                return Text(state.msg);
              },
              error: (state) => Text(state.errorMsg),
            ),
          ],
        ),
      ),
    );
  }
}
