import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/shared/widgets/custom_button_widget.dart';

void main() {
  group('CustomButtonWidget', () {
    testWidgets('renders filled button with text', (tester) async {
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

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(CustomButtonWidget), findsOneWidget);
    });

    testWidgets('renders outlined button with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.outlined(
              text: 'Outlined Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outlined Button'), findsOneWidget);
    });

    testWidgets('renders text button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.text(
              text: 'Text Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Click Me',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Click Me'));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Disabled',
              onPressed: null,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();

      expect(pressed, false);
    });

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('shows prefix icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'With Icon',
              onPressed: () {},
              prefixIcon: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);
    });

    testWidgets('shows suffix icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'With Suffix',
              onPressed: () {},
              suffixIcon: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('With Suffix'), findsOneWidget);
    });

    testWidgets('hides icons when loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Loading with icons',
              onPressed: () {},
              prefixIcon: const Icon(Icons.add),
              suffixIcon: const Icon(Icons.arrow_forward),
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('applies custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Custom Colors',
              onPressed: () {},
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(find.byType(Ink));
      final decoration = ink.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
    });

    testWidgets('expands to full width when expanded is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Expanded',
              onPressed: () {},
              expanded: true,
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(CustomButtonWidget),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(sizedBox.width, double.infinity);
    });

    testWidgets('applies custom width when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Custom Width',
              onPressed: () {},
              width: 200,
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(CustomButtonWidget),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(sizedBox.width, 200);
    });

    testWidgets('applies custom height when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Custom Height',
              onPressed: () {},
              height: 60,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(find.byType(Ink));
      expect(ink.height, 60);
    });

    testWidgets('outlined button has border', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.outlined(
              text: 'Outlined',
              onPressed: () {},
              borderColor: Colors.blue,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(find.byType(Ink));
      final decoration = ink.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      expect((decoration.border as Border).top.color, Colors.blue);
    });

    testWidgets('does not respond to tap when loading', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget.filled(
              text: 'Loading',
              onPressed: () {
                pressed = true;
              },
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(CustomButtonWidget));
      await tester.pump();

      expect(pressed, false);
    });
  });
}
