sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.error, [this.stackTrace]);
  final String error;
  final StackTrace? stackTrace;
}

extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
  
  T? get data => switch (this) {
    Success<T> success => success.data,
    Failure<T> _ => null,
  };
  
  String? get error => switch (this) {
    Success<T> _ => null,
    Failure<T> failure => failure.error,
  };
  
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(String error) onFailure,
  ) {
    return switch (this) {
      Success<T> success => onSuccess(success.data),
      Failure<T> failure => onFailure(failure.error),
    };
  }
}