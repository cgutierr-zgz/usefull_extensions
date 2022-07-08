import 'dart:math';

import 'package:flutter/material.dart';
import 'package:usefull_extensions/usefull_extensions.dart';

void main() {
  // EXTENSIONS
  // log
  'My String'.log(); // Outputs 'My String' as log

  // map
  <String, int>{'John': 20, 'Mary': 21, 'Peter': 20}
    // {Peter: 22}
    ..where((key, value) => key.length > 4 && value >= 20).log()
    // {John: 20, Mary: 21}
    ..whereKey((key) => key.length < 5).log()
    // {John: 20, Peter: 22}
    ..whereValue((value) => value.isEven).log();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usefull extensions and Widgets',
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: _SeparatedColumn(),
        ),
      ),
    );
  }
}

class _SeparatedColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _SeparatedRow(),
          const HorizontalSpacerWithText(text: 'V-Spacer with text'),
          _SeparatedRow(),
          /* Converts to - */
          HorizontalSpacerWithText(text: null.unwrappedString()),
          _SeparatedRow(),
          /* Converts to ? */
          HorizontalSpacerWithText(text: null.unwrappedString('?')),
          _SeparatedRow(),
          /* Converts to Carlos g */
          HorizontalSpacerWithText(text: 'carlos g'.toCapitalized()),
          _SeparatedRow(),
          /* Converts to Carlos G */
          HorizontalSpacerWithText(text: 'carlos g'.toTitleCase()),
          _SeparatedRow(),
        ]
            /* Separates Vertically */
            .joinWithSeparator(VerticalSpacer.large()),
      ),
    );
  }
}

class _SeparatedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _RandomContainer(),
          _RandomContainer(),
          _RandomContainer(),
          _RandomContainer(),
        ]
            /* Separates Horizontally */
            .joinWithSeparator(HorizontalSpacer.large())
            /* Adds Paddings */
            .spaced(),
      ),
    );
  }
}

class _RandomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rand = Random();
    final color = Colors.primaries[rand.nextInt(Colors.primaries.length)];
    final size = (rand.nextInt(100) + 50).toDouble();

    return Container(color: color, height: size, width: size);
  }
}
