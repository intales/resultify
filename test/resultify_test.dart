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
  });
}
