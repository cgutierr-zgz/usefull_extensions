import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usefull_extensions/usefull_extensions.dart';

import 'helpers/pump_app.dart';
import 'helpers/test_helpers.dart';

void main() {
  group('Strings extensions', () {
    const text = 'exception test';
    test('Capitalized text', () {
      final result = text.toCapitalized();

      expect(
        result,
        equals('Exception test'),
      );
    });

    test('Capitalized without text', () {
      const String? test = null;
      final result = test?.toCapitalized();

      expect(
        result,
        equals(null),
      );
    });

    test('TitleCase with text', () {
      final result = text.toTitleCase();

      expect(
        result,
        equals('Exception Test'),
      );
    });

    test('TitleCase without text', () {
      const String? test = null;
      final result = test?.toTitleCase();

      expect(
        result,
        equals(null),
      );
    });
  });

  group('Widgets extensions', () {
    const items = <Widget>[
      Text('a'),
      Text('b'),
      Text('c'),
      Text('d'),
    ];
    test('Adding separator', () {
      final result = items.joinWithSeparator(HorizontalSpacer.semi());

      expect(
        result.length,
        equals(7),
      );
    });

    test('Adding separator on a single widget', () {
      final result = [const Text('a')].joinWithSeparator(
        HorizontalSpacer.semi(),
      );

      expect(
        result.length,
        equals(1),
      );
    });

    test('Adding space should equal same ammount of Widgets, but with padding',
        () {
      final result = items.spaced();

      expect(
        result.length,
        equals(items.length),
      );
    });

    test('Adding a Spacer widget', () {
      final result = [...items, const Spacer()].spaced();

      expect(
        result.length,
        equals(items.length + 1),
      );
    });

    testWidgets(
      'Finds padding when spacing the widgets',
      (tester) async {
        await tester.pumpApp(
          Column(children: items.spaced()),
        );
        expect(find.byType(Padding), findsNWidgets(items.length));
      },
    );
    testWidgets(
      '''Finds paddings when spacing the widgets, doesnt add padding to this to Spacer''',
      (tester) async {
        await tester.pumpApp(
          Column(children: [...items, const Spacer()].spaced()),
        );
        expect(find.byType(Padding), findsNWidgets(items.length));
      },
    );
  });

  group('Object extensions', () {
    test('Log on object', () {
      final strLen = 'MyOutput'.log();

      expect(strLen, 8);
    });
    test('Unwrapped string on object?', () {
      dynamic model;

      model = null.unwrappedString();
      expect(model, '-');

      model = null.unwrappedString('?');
      expect(model, '?');

      model = 'test'.unwrappedString();
      expect(model, 'test');

      model = true;
      expect(model, true);
    });
  });

  group('Object Map<K,V>', () {
    test('where extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.where((key, value) => key.length > 4 && value > 20);

      expect(subMap, {'Peter': 22});
    });
    test('whereKey extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.whereKey((key) => key.length < 5);

      expect(subMap, {'John': 20, 'Mary': 21});
    });
    test('whereValue extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.whereValue((value) => value.isEven);

      expect(subMap, {'John': 20, 'Peter': 22});
    });
  });
  group('Paddings', () {
    testWidgets(
      'Vetical Spacer',
      (tester) async {
        await tester.pumpApp(
          Column(
            children: [
              const Text('1'),
              VerticalSpacer.xSmall(),
              VerticalSpacer.small(),
              VerticalSpacer.normal(),
              VerticalSpacer.semi(),
              VerticalSpacer.mediumSmall(),
              VerticalSpacer.medium(),
              VerticalSpacer.medium20(),
              VerticalSpacer.mediumLarge(),
              VerticalSpacer.large(),
              VerticalSpacer.xLarge(),
              VerticalSpacer.xxLarge(),
              VerticalSpacer.xxxLarge(),
              // 12 types of spacers
              const Text('2')
            ],
          ),
        );
        expect(find.byType(VerticalSpacer), findsNWidgets(12));
      },
    );
    testWidgets(
      'Horizonal Spacer',
      (tester) async {
        await tester.pumpApp(
          Column(
            children: [
              const Text('1'),
              HorizontalSpacer.xSmall(),
              HorizontalSpacer.small(),
              HorizontalSpacer.normal(),
              HorizontalSpacer.semi(),
              HorizontalSpacer.mediumSmall(),
              HorizontalSpacer.medium(),
              HorizontalSpacer.medium20(),
              HorizontalSpacer.mediumLarge(),
              HorizontalSpacer.large(),
              HorizontalSpacer.xLarge(),
              HorizontalSpacer.xxLarge(),
              HorizontalSpacer.xxxLarge(),
              // 12 types of spacers
              const Text('2')
            ],
          ),
        );
        expect(find.byType(HorizontalSpacer), findsNWidgets(12));
      },
    );
    testWidgets(
      'Horizonal Spacer with text',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;
        const hText = 'Horizontal spacer text!';
        await tester.pumpApp(
          const VerticalSpacerWithText(
            text: hText,
            color: Colors.red,
          ),
        );
        expect(find.byType(VerticalSpacerWithText), findsNWidgets(1));
        expect(find.text(hText), findsOneWidget);
      },
    );
  });
}
