import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_challenge/providers/providers.dart';

/// An [IconButton] that takes [BuildContext], when pressed will show an
/// [AlertDialog] which has the options to change the [Locale] of the app.
class LanguageChangeButton extends ConsumerWidget {
  /// Create a new instance of LanguageChangeButton.
  const LanguageChangeButton({
    Key? key,
    required this.appContext,
  }) : super(key: key);

  /// Use the App's `context` so that the app rebuilds when
  /// `appContext.setLocale()` is called.
  final BuildContext appContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.language,
        color: Colors.white,
      ),
      onPressed: () async {
        // ignore: inference_failure_on_function_invocation
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          appContext.setLocale(const Locale('en', 'US'));
                          ref.read(greetingApiProvider.notifier).reset();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: const Text('English'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          appContext.setLocale(const Locale('vi'));
                          ref.read(greetingApiProvider.notifier).reset();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: const Text('Tiếng Việt'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
