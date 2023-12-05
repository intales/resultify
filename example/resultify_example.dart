import 'package:resultify/resultify.dart';

void main() {
  standardUsage();
  print("\n");
  functionWrapping();
  print("\n");
  usingContext();
}

/// Standard usage of Result.
///
/// Here is shown how to use the Result type in a "standard" way.
void standardUsage() {
  // Declare a function that returns a Result.
  Result<int, String> divide(int a, int b) {
    if (b == 0) return Result.error("Cannot divide by zero");
    return Result.success(a ~/ b);
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

  final successResult = Result.wrap(successFunction, errorMapper: (e) => null);
  // Prints 'Success!'
  print(successResult.getResultOrDefault());

  final errorResult = Result.wrap(errorFunction, errorMapper: (e) => e);
  // Prints 'Error!'
  print(errorResult.getErrorOrDefault());
}

/// Using context.
///
/// You can also give context to errors and results. This should help you debugging.
/// This could be helpful with generic operations and make the flow of logic much cleaner.
void usingContext() {
  Result<String, String> cook(String something) {
    return Result.success("I cooked $something");
  }

  final result = cook("Pasta").withContext("Trying to cook pasta");
  print(result);
}
