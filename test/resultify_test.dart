import 'package:resultify/resultify.dart';
import 'package:test/test.dart';

void main() {
  group('Result<R, E> tests', () {
    test(
        'Given a function that does not throw an Exception should return a successful Result',
        () {
      // Arrange
      function() => "Successful";

      // Act
      final result = Result.wrap(function, errorMapper: (e) => null);

      // Assert
      expect(result.isSuccess, true);
      expect(result.isError, false);
      expect(result.getResultOrDefault(), "Successful");
    });

    test(
        'Given a function that does throw an Exception should return an error Result',
        () {
      // Arrange
      function() => throw "Throwing error";

      // Act
      final result = Result.wrap(function, errorMapper: (e) => "Got Error: $e");

      // Assert
      expect(result.isError, true);
      expect(result.isSuccess, false);
      expect(result.getErrorOrDefault(), "Got Error: Throwing error");
    });

    test(
        'Given an async Function should return a successful Future<Result<R,E>',
        () async {
      // Arrange
      asyncFunction() => Future.delayed(const Duration(milliseconds: 50))
          .then((_) => "Here is a Future!");

      // Act
      final result =
          await Result.wrapFuture(asyncFunction, errorMapper: (_) => null);

      // Assert
      expect(result.isSuccess, true);
    });

    test('Given an async Function should return an error Future<Result<R,E>',
        () async {
      // Arrange
      asyncFunction() => Future.delayed(const Duration(milliseconds: 50))
          .then((_) => throw "Here is an error :(");

      // Act
      final result =
          await Result.wrapFuture(asyncFunction, errorMapper: (err) => err);

      // Assert
      expect(result.isError, true);
    });
  });
}
