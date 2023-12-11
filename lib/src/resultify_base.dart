typedef Result<R, E> = (R?, E?);

extension Resultify<R, E> on Result<R, E> {
  /// Returns `true` if the result is successful.
  bool get isSuccess => this.$1 != null;

  /// Returns `true` if the result is an error.
  bool get isError => this.$2 != null;

  /// Matches the result, invoking the appropriate callback based on success or error.
  T match<T>({
    required T Function(R result) onSuccess,
    required T Function(E error) onError,
  }) =>
      //ignore: null_check_on_nullable_type_parameter
      isSuccess ? onSuccess(this.$1!) : onError(this.$2!);

  /// Gets the result or a [defaultValue] if the result is not successful.
  R? getResultOrDefault({R? defaultValue}) =>
      isSuccess ? this.$1! : defaultValue;

  /// Gets the error or a [defaultValue] if the result is not an error.
  E? getErrorOrDefault({E? defaultValue}) => isError ? this.$2! : defaultValue;

  /// Builds a successful [Result].
  static Result<R, E> success<R, E>(R result) => (result, null);

  /// Builds an unsuccessful [Result].
  static Result<R, E> error<R, E>(E error) => (null, error);

  /// Executes the provided [function] and wraps the result in a [Result] type,
  /// handling exceptions and mapping them to the specified error type with [errorMapper].
  static Result<R, E> wrap<R, E>(
    R Function() function, {
    required E Function(Object) errorMapper,
  }) {
    try {
      final result = function();
      return (result, null);
    } catch (e) {
      final error = errorMapper(e);
      return (null, error);
    }
  }

  /// Executes the provided Future [function] and wraps the result in a [Future<Result>] type,
  /// handling exceptions and mapping them to the specified error type with [errorMapper].
  static Future<Result<R, E>> wrapFuture<R, E>(
    Future<R> Function() function, {
    required E Function(Object) errorMapper,
  }) async {
    try {
      final result = await function();
      return (result, null);
    } catch (e) {
      final error = errorMapper(e);
      return (null, error);
    }
  }
}
