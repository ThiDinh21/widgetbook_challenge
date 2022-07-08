import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChangeButton extends StatelessWidget {
  LanguageChangeButton({
    Key? key,
    required this.appContext,
  }) : super(key: key);

  BuildContext appContext;

  @override
  Widget build(BuildContext context) {
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
