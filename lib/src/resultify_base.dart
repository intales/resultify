/// A generic result type for handling success or error outcomes in Dart.
class Result<R, E> {
  final R? _result;
  final E? _error;

  /// Constructs a successful result with the provided [result].
  Result.success(this._result) : _error = null;

  /// Constructs an error result with the provided [error].
  Result.error(this._error) : _result = null;

  /// Returns `true` if the result is successful.
  bool get isSuccess => _result != null;

  /// Returns `true` if the result is an error.
  bool get isError => _error != null;

  /// Gets the result or a [defaultValue] if the result is not successful.
  R? getResultOrDefault({R? defaultValue}) =>
      isSuccess ? _result! : defaultValue;

  /// Gets the error or a [defaultValue] if the result is not an error.
  E? getErrorOrDefault({E? defaultValue}) => isError ? _error! : defaultValue;

  /// Matches the result, invoking the appropriate callback based on success or error.
  void match({
    required void Function(R result) onSuccess,
    required void Function(E error) onError,
  }) =>
      //ignore: null_check_on_nullable_type_parameter
      isSuccess ? onSuccess(_result!) : onError(_error!);

  /// Executes the provided [function] and wraps the result in a Result type,
  /// handling exceptions and mapping them to the specified error type with [errorMapper].
  static Result<R, E> wrap<R, E>(
    R Function() function, {
    required E Function(Object) errorMapper,
  }) {
    try {
      final result = function();
      return Result.success(result);
    } catch (e) {
      final error = errorMapper(e);
      return Result.error(error);
    }
  }
}
