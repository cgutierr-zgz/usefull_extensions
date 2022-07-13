import 'dart:developer' as devtools;
import 'package:flutter/material.dart';

/// A collection of usefull extensions on [String]
extension StringCasingExtension on String {
  /// Converts the first letter of a [String] into uppercase
  /// or returns '' if null
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toCapitalized(); // Carlos gutiérrez
  /// ```
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Converts all the first letters of each words of a given [String] into
  /// uppercase
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toTitleCase(); // Carlos Gutiérrez
  /// ```
  /// See also:
  ///
  ///  * [toCapitalized]
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

/// A collection of usefull extensions on [List<Widget>]
extension JoinedWidgets on List<Widget> {
  /// Adds a specific type of [Widget] in between a list of Widgets
  /// This can be usefull to add some height in between Widgets
  /// without the need of writing it multiple times
  ///
  /// Example:
  /// ```dart
  /// [
  ///  const Text('CARLOS'),
  ///  const Text('MOBILE SOLUTIONS'),
  /// ].joinWithSeparator(const SizedBox(height: 10));
  /// ```
  List<Widget> joinWithSeparator(Widget? separator) {
    return length > 1
        ? (take(length - 1)
            .map(
              (widget) =>
                  [widget, separator ?? const SizedBox(height: 24, width: 24)],
            )
            .expand((widget) => widget)
            .toList()
          ..add(last))
        : this;
  }

  /// Adds the same ammount of padding to a list of Widgets
  /// This can be usefull if you need to have some of the widgets of a list
  /// spaced, and some don't
  ///
  /// Example:
  /// ```dart
  /// [
  ///   const Text('CARLOS'),
  ///   const Text('MOBILE SOLUTIONS'),
  /// ].spaced();
  /// // or
  /// ].spaced(padding: const EdgeInsets.all(10));
  /// ```
  List<Widget> spaced({EdgeInsetsGeometry? padding, bool excludeFlex = true}) {
    final spacedWidgets = <Widget>[];
    for (final w in this) {
      if (excludeFlex && (w is Expanded || w is Spacer || w is Flexible)) {
        spacedWidgets.add(w);
      } else {
        spacedWidgets.add(
          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: w,
          ),
        );
      }
    }
    return spacedWidgets;
  }
}

/// {@template log_extension}
/// Emit a log event of the current object
/// {@endtemplate}
extension Log on Object {
  /// {@macro log_extension}
  /// Example:
  /// ```dart
  /// final model = Model();
  /// model.log(); // outputs the model toString in a log event
  ///              //and returns the string length
  /// ```
  int log() {
    final str = toString();
    devtools.log(str);

    // returns the length of the ouput
    return str.length;
  }
}

/// {@template unwrapped_extension}
/// Returns the current object.toString() in a safe way
/// {@endtemplate}
extension UnwrappedString on Object? {
  /// {@macro unwrapped_extension}
  /// Example:
  /// ```dart
  /// final Model? model = // My call which returns Model?
  /// // Returns the actual toString if its not null
  /// // or
  /// model.unwrappedString() // '-'
  /// model.unwrappedString('?') // '?'
  /// ```
  String unwrappedString([String replacement = '-']) => this == null
      ? replacement
      : (this as String?)!.isEmpty
          ? replacement
          : toString();
}

/// {@template map_extension}
/// Allows us to find an entry
/// {@endtemplate}
extension DetailedWhere<K, V> on Map<K, V> {
  /// {@macro map_extension}
  /// based on key and value
  ///
  /// Example:
  /// ```dart
  /// people.where((key, value) => key.length > 4 && value >= 20);
  /// // {Peter: 22}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
        entries.where((entry) => f(entry.key, entry.value)),
      );

  /// {@macro map_extension}
  /// based on key
  ///
  /// Example:
  /// ```dart
  /// people.whereKey((key) => key.length < 5);
  /// // {John: 20, Mary: 21}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};

  /// {@macro map_extension}
  /// based on  value
  ///
  /// Example:
  /// ```dart
  /// people.whereValue((value) => value.isEven);
  /// // {John: 20, Peter: 22}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}

/// {@template dimens}
/// Defines the default Dimens for padding to be used as guidelines
///
/// Example:
/// ```dart
/// SizedBox(height: Dimenx.paddingSemi) // 10
/// ```
/// {@endtemplate}
abstract class Dimens {
  /// padding of [2.0]
  /// {@macro map_extension}
  static const double paddingXSmall = 2;

  /// padding of [4.0]
  /// {@macro map_extension}
  static const double paddingSmall = 4;

  /// padding of [8.0]
  /// {@macro map_extension}
  static const double paddingDefault = 8;

  /// padding of [10.0]
  /// {@macro map_extension}
  static const double paddingSemi = 10;

  /// padding of [12.0]
  /// {@macro map_extension}
  static const double paddingMediumSmall = 12;

  /// padding of [16.0]
  /// {@macro map_extension}
  static const double paddingMedium = 16;

  /// padding of [20.0]
  /// {@macro map_extension}
  static const double paddingMedium20 = 20;

  /// padding of [24.0]
  /// {@macro map_extension}
  static const double paddingMediumLarge = 24;

  /// padding of [32.0]
  /// {@macro map_extension}
  static const double paddingLarge = 32;

  /// padding of [36.0]
  /// {@macro map_extension}
  static const double paddingXLarge = 36;

  /// padding of [48.0]
  /// {@macro map_extension}
  static const double paddingXXLarge = 48;

  /// padding of [64.0]
  /// {@macro map_extension}
  static const double paddingXXXLarge = 64;
}

/// [VerticalSpacer] creates a vertical separation between Widgets
/// the same way you would use a SizedBox, but with predefined values
/// from [Dimens]
///
/// Example:
/// ```dart
///    VerticalSpacer.xSmall(),
///    VerticalSpacer.small(),
///    VerticalSpacer.normal(),
///    VerticalSpacer.semi(),
///    VerticalSpacer.mediumSmall(),
///    VerticalSpacer.medium(),
///    VerticalSpacer.medium20(),
///    VerticalSpacer.mediumLarge(),
///    VerticalSpacer.large(),
///    VerticalSpacer.xLarge(),
///    VerticalSpacer.xxLarge(),
///    VerticalSpacer.xxxLarge(),
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [HorizontalSpacer]
///  * [VerticalSpacerWithText]
class VerticalSpacer extends SizedBox {
  /// [VerticalSpacer] with custom paddings
  const VerticalSpacer({super.key, required double super.height});

  /// [VerticalSpacer] with [2.0] as padding
  factory VerticalSpacer.xSmall() =>
      const VerticalSpacer(height: Dimens.paddingXSmall);

  /// [VerticalSpacer] with [4.0] as padding
  factory VerticalSpacer.small() =>
      const VerticalSpacer(height: Dimens.paddingSmall);

  /// [VerticalSpacer] with [8.0] as padding
  factory VerticalSpacer.normal() =>
      const VerticalSpacer(height: Dimens.paddingDefault);

  /// [VerticalSpacer] with [10.0] as padding
  factory VerticalSpacer.semi() =>
      const VerticalSpacer(height: Dimens.paddingSemi);

  /// [VerticalSpacer] with [12.0] as padding
  factory VerticalSpacer.mediumSmall() =>
      const VerticalSpacer(height: Dimens.paddingMediumSmall);

  /// [VerticalSpacer] with [16.0] as padding
  factory VerticalSpacer.medium() =>
      const VerticalSpacer(height: Dimens.paddingMedium);

  /// [VerticalSpacer] with [20.0] as padding
  factory VerticalSpacer.medium20() =>
      const VerticalSpacer(height: Dimens.paddingMedium20);

  /// [VerticalSpacer] with [24.0] as padding
  factory VerticalSpacer.mediumLarge() =>
      const VerticalSpacer(height: Dimens.paddingMediumLarge);

  /// [VerticalSpacer] with [32.0] as padding
  factory VerticalSpacer.large() =>
      const VerticalSpacer(height: Dimens.paddingLarge);

  /// [VerticalSpacer] with [36.0] as padding
  factory VerticalSpacer.xLarge() =>
      const VerticalSpacer(height: Dimens.paddingXLarge);

  /// [VerticalSpacer] with [48.0] as padding
  factory VerticalSpacer.xxLarge() =>
      const VerticalSpacer(height: Dimens.paddingXXLarge);

  /// [VerticalSpacer] with [64.0] as padding
  factory VerticalSpacer.xxxLarge() =>
      const VerticalSpacer(height: Dimens.paddingXXXLarge);
}

/// [HorizontalSpacer] creates a horizontal separation between Widgets
/// the same way you would use a SizedBox, but with predefined values
/// from [Dimens]
///
/// Example:
/// ```dart
///    HorizontalSpacer.small(),
///    HorizontalSpacer.normal(),
///    HorizontalSpacer.semi(),
///    HorizontalSpacer.mediumSmall(),
///    HorizontalSpacer.medium(),
///    HorizontalSpacer.medium20(),
///    HorizontalSpacer.mediumLarge(),
///    HorizontalSpacer.large(),
///    HorizontalSpacer.xLarge(),
///    HorizontalSpacer.xxLarge(),
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [VerticalSpacer]
///  * [VerticalSpacerWithText]
class HorizontalSpacer extends SizedBox {
  /// [HorizontalSpacer] with custom paddings
  const HorizontalSpacer({super.key, required double super.width});

  /// [HorizontalSpacer] with [2.0] as padding
  factory HorizontalSpacer.xSmall() =>
      const HorizontalSpacer(width: Dimens.paddingXSmall);

  /// [HorizontalSpacer] with [4.0] as padding
  factory HorizontalSpacer.small() =>
      const HorizontalSpacer(width: Dimens.paddingSmall);

  /// [HorizontalSpacer] with [8.0] as padding
  factory HorizontalSpacer.normal() =>
      const HorizontalSpacer(width: Dimens.paddingDefault);

  /// [HorizontalSpacer] with [10.0] as padding
  factory HorizontalSpacer.semi() =>
      const HorizontalSpacer(width: Dimens.paddingSemi);

  /// [HorizontalSpacer] with [12.0] as padding
  factory HorizontalSpacer.mediumSmall() =>
      const HorizontalSpacer(width: Dimens.paddingMediumSmall);

  /// [HorizontalSpacer] with [16.0] as padding
  factory HorizontalSpacer.medium() =>
      const HorizontalSpacer(width: Dimens.paddingMedium);

  /// [HorizontalSpacer] with [20.0] as padding
  factory HorizontalSpacer.medium20() =>
      const HorizontalSpacer(width: Dimens.paddingMedium20);

  /// [HorizontalSpacer] with [24.0] as padding
  factory HorizontalSpacer.mediumLarge() =>
      const HorizontalSpacer(width: Dimens.paddingMediumLarge);

  /// [HorizontalSpacer] with [32.0] as padding
  factory HorizontalSpacer.large() =>
      const HorizontalSpacer(width: Dimens.paddingLarge);

  /// [HorizontalSpacer] with [36.0] as padding
  factory HorizontalSpacer.xLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXLarge);

  /// [HorizontalSpacer] with [48.0] as padding
  factory HorizontalSpacer.xxLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXXLarge);

  /// [HorizontalSpacer] with [64.0] as padding
  factory HorizontalSpacer.xxxLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXXXLarge);
}

/// [VerticalSpacerWithText] creates a horizontal separation between Widgets
/// with a text in between
///
/// Example:
/// ```dart
///    VerticalSpacerWithText(
///      text: 'example text',
///      color: Colors.green,
///    );
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [VerticalSpacer]
///  * [VerticalSpacerWithText]
class VerticalSpacerWithText extends StatelessWidget {
  /// [HorizontalSpacer] with custom attributes
  const VerticalSpacerWithText({
    super.key,
    required this.text,
    this.textStyle,
    this.color,
    this.height = 36,
    this.thickness = 1.0,
  });

  /// Text that will be displayed in between widgets
  final String text;

  /// Style of the text in between dividers
  final TextStyle? textStyle;

  /// Color of the separation in between widgets
  final Color? color;

  /// Height of the divider
  final double? height;

  /// Thickness of the divider
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _line(),
        VerticalSpacer.small(),
        Text(text, style: textStyle),
        VerticalSpacer.small(),
        _line(),
      ],
    );
  }

  Widget _line() => Expanded(
        child: Container(
          margin: const EdgeInsets.all(Dimens.paddingMedium20),
          child: Divider(thickness: thickness, color: color, height: height),
        ),
      );
}

/// {@template theme_extension}
/// Allows access to the current theme data
/// {@endtemplate}
extension ThemeExtension on BuildContext {
  /// {@macro theme_extension}
  /// Example:
  /// ```dart
  /// final theme = context.theme; // Access current theme data
  /// ```
  ThemeData get theme => Theme.of(this);
}
