import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

part 'providers.freezed.dart';

/// Provides an [WidgetbookApi] instance for the whole app.
final widgetbookApiProvider = Provider<WidgetbookApi>(
  (ref) => WidgetbookApi(),
);

/// States that [GreetingApiStateNotifier] holds, change based on what
/// [WidgetbookApi] returns.
@freezed
class GreetingApiState with _$GreetingApiState {
  /// The initial state when the app starts.
  const factory GreetingApiState.initial() = _Initial;

  /// State when waiting for [WidgetbookApi] to response.
  const factory GreetingApiState.loading() = _Loading;

  /// State when [WidgetbookApi] responses with a greeting message.
  const factory GreetingApiState.success(String msg) = _Success;

  /// State when [WidgetbookApi] throws an errror or user submit invalid names.
  const factory GreetingApiState.error(String errorMsg) = _Error;
}

/// Takes and instance of [WidgetbookApi], holds [GreetingApiState]
/// and notify subscribers when the state changes.
class GreetingApiStateNotifier extends StateNotifier<GreetingApiState> {
  /// Create a new instance of [GreetingApiStateNotifier]
  /// with [_Initial] as the initial state.
  GreetingApiStateNotifier(this.api) : super(const GreetingApiState.initial());

  /// An instance of [WidgetbookApi].
  final WidgetbookApi api;

  /// Takes a [String] and passes to [WidgetbookApi]'s `welcomeToWidgetbook()`
  /// and updates the state which is of type [GreetingApiState] base on
  /// the input and how [WidgetbookApi] responses.
  Future<void> submitUsername(String username) async {
    if (username.isEmpty) {
      final errorMsg = tr('empty_str_error_msg');
      state = GreetingApiState.error(errorMsg);
      return;
    }

    state = const GreetingApiState.loading();
    try {
      final msg = await api.welcomeToWidgetbook(message: username);
      state = GreetingApiState.success(msg);
    } catch (e) {
      final errorMsg = tr('server_error_msg');
      state = GreetingApiState.error(errorMsg);
    }
  }

  /// Reset the state back to initial.
  void reset() {
    state = const GreetingApiState.initial();
  }
}

/// Provides an instance of [GreetingApiStateNotifier] to the whole app.
final greetingApiProvider =
    StateNotifierProvider<GreetingApiStateNotifier, GreetingApiState>(
  (ref) {
    final widgetbookApi = ref.watch(widgetbookApiProvider);
    return GreetingApiStateNotifier(widgetbookApi);
  },
);
