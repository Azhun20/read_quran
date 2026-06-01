# Testing Guide

This guide explains how to run and write tests for the Read Quran application.

## Overview

The project uses Flutter's testing framework with the following test types:
- **Unit Tests**: Test individual classes and functions in isolation
- **Widget Tests**: Test UI components and their interactions

## Current Test Coverage

```
Overall Coverage: 43.83% (199/454 lines)
├─ Domain Layer: 100% (Critical business logic)
├─ Use Cases: 100%
└─ Entities: 100%
```

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

This generates a coverage report in `coverage/lcov.info`.

### Run Specific Test File

```bash
flutter test test/features/quran_search/domain/usecases/get_quran_search_list_usecase_test.dart
```

### Run Tests in a Directory

```bash
flutter test test/features/quran_search/
```

### Run Tests with Verbose Output

```bash
flutter test --verbose
```

### Run Tests in Watch Mode (Auto-rerun on changes)

```bash
flutter test --watch
```

## Viewing Coverage Report

### Generate HTML Coverage Report

1. Install `lcov` tool:
   ```bash
   # macOS
   brew install lcov

   # Linux
   sudo apt-get install lcov
   ```

2. Generate HTML report:
   ```bash
   flutter test --coverage
   genhtml coverage/lcov.info -o coverage/html
   ```

3. Open the report:
   ```bash
   open coverage/html/index.html
   ```

### Using VS Code Coverage Gutters Extension

1. Install "Coverage Gutters" extension
2. Run tests with coverage:
   ```bash
   flutter test --coverage
   ```
3. Click "Watch" in the bottom status bar to see coverage highlights in your code

## Test Structure

```
test/
├── features/
│   ├── quran_search/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── get_quran_search_list_usecase_test.dart
│   │   └── presentation/
│   │       └── cubit/
│   │           └── quran_search_cubit_test.dart
│   ├── quran_list/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       └── cubit/
│   └── quran_detail/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           └── cubit/
└── shared/
    └── widgets/
        └── custom_button_widget_test.dart
```

## Writing Unit Tests

### Example: Testing a Use Case

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

// Generate mocks with build_runner
@GenerateMocks([QuranSearchRepository])
void main() {
  late SearchQuranUseCase useCase;
  late MockQuranSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockQuranSearchRepository();
    useCase = SearchQuranUseCase(mockRepository);
  });

  group('SearchQuranUseCase', () {
    test('should return list of ayahs when search is successful', () async {
      // Arrange
      final expectedAyahs = [/* test data */];
      when(mockRepository.searchQuran(
        keyword: 'mercy',
        surahNumber: null,
        edition: 'quran-simple',
      )).thenAnswer((_) async => Right(expectedAyahs));

      // Act
      final result = await useCase(
        keyword: 'mercy',
        surahNumber: null,
        edition: 'quran-simple',
      );

      // Assert
      expect(result, Right(expectedAyahs));
      verify(mockRepository.searchQuran(
        keyword: 'mercy',
        surahNumber: null,
        edition: 'quran-simple',
      )).called(1);
    });
  });
}
```

### Generating Mocks

After adding `@GenerateMocks` annotation, run:

```bash
dart run build_runner build
```

Or watch mode for continuous generation:

```bash
dart run build_runner watch
```

## Writing Widget Tests

### Example: Testing a Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomButtonWidget displays text correctly', (tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButtonWidget.filled(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verify the text is displayed
    expect(find.text('Test Button'), findsOneWidget);
  });

  testWidgets('CustomButtonWidget calls onPressed when tapped', (tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButtonWidget.filled(
            text: 'Test Button',
            onPressed: () => wasPressed = true,
          ),
        ),
      ),
    );

    // Tap the button
    await tester.tap(find.text('Test Button'));
    await tester.pump();

    // Verify callback was called
    expect(wasPressed, true);
  });
}
```

## Testing Cubits/Blocs

### Example: Testing Cubit States

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('QuranSearchCubit', () {
    late QuranSearchCubit cubit;
    late MockSearchQuranUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockSearchQuranUseCase();
      cubit = QuranSearchCubit(searchQuranUseCase: mockUseCase);
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<QuranSearchCubit, QuranSearchState>(
      'emits [loading, success] when search is successful',
      build: () {
        when(mockUseCase(
          keyword: 'mercy',
          surahNumber: null,
          edition: 'quran-simple',
        )).thenAnswer((_) async => Right([/* test data */]));
        return cubit;
      },
      act: (cubit) => cubit.searchQuran(keyword: 'mercy'),
      expect: () => [
        QuranSearchState(isLoading: true, searchKeyword: 'mercy'),
        QuranSearchState(
          isLoading: false,
          searchResults: [/* test data */],
          resultCount: 1,
        ),
      ],
    );
  });
}
```

## Best Practices

### 1. Test Organization

- **Arrange-Act-Assert (AAA)**: Structure tests clearly
  ```dart
  test('description', () {
    // Arrange: Set up test data and mocks
    final input = 'test';

    // Act: Execute the code being tested
    final result = functionUnderTest(input);

    // Assert: Verify the result
    expect(result, expectedOutput);
  });
  ```

### 2. Use Descriptive Test Names

```dart
// Good
test('should return ServerFailure when repository throws DioException', () {});

// Bad
test('test1', () {});
```

### 3. One Assertion per Test

```dart
// Good
test('should return correct surah count', () {
  expect(result.length, 114);
});

test('should return surahs in correct order', () {
  expect(result.first.number, 1);
});

// Avoid
test('should validate surah list', () {
  expect(result.length, 114);
  expect(result.first.number, 1);
  expect(result.last.number, 114);
});
```

### 4. Clean Up Resources

```dart
tearDown(() {
  cubit.close();
  mockRepository.reset();
});
```

### 5. Use Test Groups

```dart
group('QuranSearchCubit', () {
  group('searchQuran', () {
    test('should emit loading state', () {});
    test('should emit success state', () {});
    test('should emit error state', () {});
  });

  group('clearSearch', () {
    test('should reset to initial state', () {});
  });
});
```

## Common Testing Patterns

### Testing Async Code

```dart
test('async test', () async {
  final result = await asyncFunction();
  expect(result, expectedValue);
});
```

### Testing Streams

```dart
test('stream test', () {
  expectLater(
    streamFunction(),
    emitsInOrder([value1, value2, emitsDone]),
  );
});
```

### Pump and Settle for Animations

```dart
testWidgets('animation test', (tester) async {
  await tester.pumpWidget(MyWidget());

  // Trigger animation
  await tester.tap(find.byType(Button));

  // Wait for all animations to complete
  await tester.pumpAndSettle();

  expect(find.text('Animated Text'), findsOneWidget);
});
```

## Continuous Integration

Tests run automatically on every push via GitHub Actions. See `.github/workflows/test.yml` for configuration.

## Troubleshooting

### Tests Fail Locally but Pass in CI

- Ensure you're on the same Flutter version: `flutter --version`
- Clean and get dependencies: `flutter clean && flutter pub get`
- Regenerate mocks: `dart run build_runner build --delete-conflicting-outputs`

### Coverage Not Generating

- Ensure `lcov` is installed
- Check file permissions in `coverage/` directory
- Try: `flutter clean && flutter test --coverage`

### Widget Tests Timing Out

- Increase timeout: `testWidgets('test', (tester) async {}, timeout: Timeout(Duration(seconds: 30)));`
- Use `pumpAndSettle()` to wait for animations

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [BlocTest Documentation](https://pub.dev/packages/bloc_test)
- [Testing Best Practices](https://docs.flutter.dev/testing/best-practices)

## Current Test Results

Last run: 47 tests passing ✓

```
00:04 +47: All tests passed!
```

Coverage: 43.83% overall, 100% on critical business logic (domain layer).
