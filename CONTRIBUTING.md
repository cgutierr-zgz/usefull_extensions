# Contributing to usefull_extensions package

- Document new extensions **with examples** in both `.dart` files and `README.md` **Extensions** section
- If necessary add the new export to `usefull_extensions.dart` file
- **Fix all linting issues** and run `flutter format .`
- Run `dart pub publish --dry-run` to test everything it's ok
- Ensure max pub.dev score locally, first install **pana**: `flutter pub global activate pana`, and run `flutter pub global run pana ../usefull_extensions`
- If a new version is going to be published, **update version numbers** in both `CHANGELOG.md` and `pubspec.yaml`
- **Test your code** by create tests and generate a coverage file with [very_good_cli](https://pub.dev/packages/very_good_cli) using: `very_good test --coverage` afterwards, u can install `brew install lcov` and run `genhtml coverage/lcov.info -o coverage/html`to generate a `.html` report and see the actual code coverage.
You can also install [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) in VSCode to see real-time coverage in the IDE once the lcov is generated.

```bash
very_good test --coverage && genhtml coverage/lcov.info -o coverage/html
```

- Run `flutter clean` in example folder

# Publishing

Use `dart pub publish` when everything is ready for a new version