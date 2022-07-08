import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

part 'providers.freezed.dart';

final widgetbookApiProvider = Provider<WidgetbookApi>(
  (ref) => WidgetbookApi(),
);

@freezed
class GreetingApiState with _$GreetingApiState {
  const factory GreetingApiState.initial() = _Initial;
  const factory GreetingApiState.loading() = _Loading;
  const factory GreetingApiState.success(String msg) = _Success;
  const factory GreetingApiState.error(String errorMsg) = _Error;
}

class GreetingApiStateNotifier extends StateNotifier<GreetingApiState> {
  GreetingApiStateNotifier(this.api) : super(const GreetingApiState.initial());

  final WidgetbookApi api;

  Future<void> submitUsername(String username) async {
    if (username.isEmpty) {
      const errorMsg = "Your name can't be empty!";
      state = const GreetingApiState.error(errorMsg);
      return;
    }

    state = const GreetingApiState.loading();
    try {
      final msg = await api.welcomeToWidgetbook(message: username);
      state = GreetingApiState.success(msg);
    } catch (e) {
      const errorMsg = 'An unexpected error has occurred. Please try again';
      state = const GreetingApiState.error(errorMsg);
    }
  }
}

final greetingApiProvider =
    StateNotifierProvider<GreetingApiStateNotifier, GreetingApiState>(
  (ref) {
    final widgetbookApi = ref.watch(widgetbookApiProvider);
    return GreetingApiStateNotifier(widgetbookApi);
  },
);
