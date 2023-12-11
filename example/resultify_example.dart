import 'package:resultify/resultify.dart';

void main() {
  standardUsage();
  print("\n");
  functionWrapping();
  print("\n");
  goStyle();
}

/// Standard usage of Result.
///
/// Here is shown how to use the Result type in a "standard" way.
void standardUsage() {
  // Declare a function that returns a Result.
  Result<int, String> divide(int a, int b) {
    if (b == 0) return Resultify.error("Cannot divide by zero");
    return Resultify.success(a ~/ b);
  }

  final result = divide(5, 3);

  // You can extract the result or a default value.
  final resultOrDefault = result.getResultOrDefault(defaultValue: 0);
  print(resultOrDefault); // Prints "1".

  // You can do the same thing with error.
  final errorOrDefault = result.getErrorOrDefault(defaultValue: "No errors :)");
  print(errorOrDefault); // Prints "No errors :)".

  // Do something based on result match.
  result.match(
    onSuccess: print,
    onError: print,
  );
}

/// Function wrapping.
///
/// Function wrapping consists in running a function in a try-catch block.
/// The `wrap` functions handles exceptions automatically and
/// can map the exception to any other object as you prefer.
void functionWrapping() {
  String successFunction() => "Success!";
  String errorFunction() => throw "Error!";

  final successResult =
      Resultify.wrap(successFunction, errorMapper: (e) => null);
  // Prints 'Success!'
  print(successResult.getResultOrDefault());

  final errorResult = Resultify.wrap(errorFunction, errorMapper: (e) => e);
  // Prints 'Error!'
  print(errorResult.getErrorOrDefault());
}

/// You can also use Resultify to have a "golang experience" wich is really nice.
void goStyle() {
  Result<String, String> foo() => Resultify.success("foo");

  final (result, err) = foo();

  if (err != null) {
    print("Ooops... something went wrong: $err");
  }

  print("Yay! $result");

  // You can also return values without the `success` or `error` constructors.
  Result<String, String> fooo() => (null, "Something went wrong :(");

  print(fooo());
}
