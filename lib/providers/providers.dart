import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

part 'providers.freezed.dart';

@freezed
class ApiState with _$ApiState {
  const factory ApiState.initial() = _Initial;
  const factory ApiState.loading() = _Loading;
  const factory ApiState.success(String msg) = _Success;
  const factory ApiState.error(String errorMsg) = _Error;
}

class ApiStateNotifier extends StateNotifier<ApiState> {
  ApiStateNotifier(this.api) : super(const ApiState.initial());

  final WidgetbookApi api;

  Future<void> submitUsername(String username) async {
    state = const ApiState.loading();
    try {
      final msg = await api.welcomeToWidgetbook(message: username);
      state = ApiState.success(msg);
    } catch (e) {
      const errorMsg = 'An unexpected error has occurred. Please try again';
      state = const ApiState.error(errorMsg);
    }
  }
}

final apiProvider = StateNotifierProvider<ApiStateNotifier, ApiState>(
  (ref) {
    return ApiStateNotifier(WidgetbookApi());
  },
);
