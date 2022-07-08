import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/providers/providers.dart';

class MockWidgetbookApi extends Mock implements WidgetbookApi {}

void main() {
  late ProviderContainer sut;
  late MockWidgetbookApi mockApi;
  const successMsg = 'Hello Test name';
  const serverErrorMsg = 'An unexpected error has occurred. Please try again';

  void arrangeWidgetbookApiReturnsTestName() {
    when(
      () => mockApi.welcomeToWidgetbook(message: 'Test name'),
    ).thenAnswer((_) async => successMsg);
  }

  void arrangeWidgetbookApiThrowsError() {
    when(
      () => mockApi.welcomeToWidgetbook(message: 'Test name'),
    ).thenThrow((_) async => UnexpectedException());
  }

  Future<void> submitTestUsername() async {
    await sut.read(greetingApiProvider.notifier).submitUsername('Test name');
  }

  Future<void> submitEmptyString() async {
    await sut.read(greetingApiProvider.notifier).submitUsername('');
  }

  setUp(() {
    mockApi = MockWidgetbookApi();
    sut = ProviderContainer(
      overrides: [
        widgetbookApiProvider.overrideWithValue(mockApi),
      ],
    );
  });

  test(
    'Initial state is GreetingApiState.initial',
    () {
      expect(sut.read(greetingApiProvider), const GreetingApiState.initial());
    },
  );

  test(
    'State changes to loading when waiting for API response',
    () async {
      arrangeWidgetbookApiReturnsTestName();
      final future = submitTestUsername();
      expect(sut.read(greetingApiProvider), const GreetingApiState.loading());
      await future;
    },
  );

  test(
    'State changes to success when API responses with a greeting message',
    () async {
      arrangeWidgetbookApiReturnsTestName();
      await submitTestUsername();
      expect(
        sut.read(greetingApiProvider),
        const GreetingApiState.success(successMsg),
      );
    },
  );

  test(
    'State changes to error if user submitted an empty string',
    () async {
      for (final _ in [1, 2, 3, 4, 5]) {
        await submitEmptyString();
        expect(
          sut.read(greetingApiProvider),
          const GreetingApiState.error("Your name can't be empty!"),
        );
      }
    },
  );

  test(
    'State changes to error when API throws an error',
    () async {
      arrangeWidgetbookApiThrowsError();
      await submitTestUsername();
      expect(
        sut.read(greetingApiProvider),
        const GreetingApiState.error(serverErrorMsg),
      );
    },
  );
}
