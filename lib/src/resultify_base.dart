/// A generic result type for handling success or error outcomes in Dart.
class Result<R, E> {
  final R? _result;
  final E? _error;
  final List<String> _context;

  /// Constructs a successful result with the provided [result].
  Result.success(this._result, {String? context})
      : _error = null,
        _context = context != null ? [context] : [];

  /// Constructs an error result with the provided [error].
  Result.error(this._error, {String? context})
      : _result = null,
        _context = context != null ? [context] : [];

  /// Returns `true` if the result is successful.
  bool get isSuccess => _result != null;

  /// Returns `true` if the result is an error.
  bool get isError => _error != null;

  /// Returns the current context of [Result].
  String get context {
    String result = "";

    for (var i = 0; i < _context.length; i++) {
      result += "$i: ${_context[i]}";
      if (i != _context.length - 1) result += "\n";
    }

    return result;
  }

  /// Gets the result or a [defaultValue] if the result is not successful.
  R? getResultOrDefault({R? defaultValue}) =>
      isSuccess ? _result! : defaultValue;

  /// Gets the error or a [defaultValue] if the result is not an error.
  E? getErrorOrDefault({E? defaultValue}) => isError ? _error! : defaultValue;

  /// Matches the result, invoking the appropriate callback based on success or error.
  T match<T>({
    required T Function(R result) onSuccess,
    required T Function(E error) onError,
  }) =>
      //ignore: null_check_on_nullable_type_parameter
      isSuccess ? onSuccess(_result!) : onError(_error!);

  /// Appends [context] to the current [Result] context and returns a new [Result].
  Result withContext(String context) {
    _context.add(context);
    return this;
  }

  @override
  String toString() {
    String status = isSuccess
        ? "Success"
        : isError
            ? "Error"
            : "Undefined";
    String string = "";
    string += "STATUS: $status\n";
    string += "RESULT: $_result\n";
    string += "ERROR: $_error\n";
    string += "CONTEXT: $context";

    return string;
  }

  /// Executes the provided [function] and wraps the result in a [Result] type,
  /// handling exceptions and mapping them to the specified error type with [errorMapper].
  static Result<R, E> wrap<R, E>(
    R Function() function, {
    required E Function(Object) errorMapper,
    String? context,
  }) {
    try {
      final result = function();
      return Result.success(result, context: context);
    } catch (e) {
      final error = errorMapper(e);
      return Result.error(error, context: context);
    }
  }
}
