# Resultify

A Dart package for result-oriented programming, providing a `Result<R, E>` type with convenient methods for streamlined error handling.

## Usage

To use this package, add `resultify` as a [dependency in your `pubspec.yaml`](https://dart.dev/guides/packages):

```yaml
dependencies:
    resultify: <latest-version>
```

Now you can import the package in your Dart code:

```dart
import 'package:resultify/resultify.dart';
```

## Result Type

The `Result<R, E>` type encapsulates either a successful result (`R`) or an error (`E`).

```dart
Result<int, String> divide(int a, int b) {
    if (b == 0) return Result.error("Cannot divide by zero");
    return a ~/ b;
}
```

## Convinient methods

The package provides convenient methods for working with results:

- `getResultOrDefault`: Gets the result or a default value.
- `getErrorOrDefault`: Gets the error or a default value.
- `match`: Matches the result, invoking callbacks based on success or error.
- `wrap`: Executes a function and wraps the result, handling exceptions.


For more examples and detailed usage, please refer to the [example](example/resultify_example.dart) directory.

## Issues and Contributions

Feel free to report issues or contribute to the project on [GitHub](https://github.com/intales/resultify).
