import 'package:dio/dio.dart';

/// Represents the state of data, including either a successful data result
/// or an error.
///
/// This is an abstract class, and there are two concrete subclasses:
/// - [DataSuccess] for successful data results.
/// - [DataFailed] for cases where an error occurred.
abstract class DataState<T> {
  final T? data;
  final DioError? error;

  /// Creates a new instance of [DataState].
  ///
  /// [data] represents the successful data result (nullable).
  /// [error] represents an error that occurred (nullable).
  const DataState({this.data, this.error});
}

/// Represents a successful data result.
///
/// This is a concrete subclass of [DataState].
class DataSuccess<T> extends DataState<T> {
  /// Creates a new instance of [DataSuccess].
  ///
  /// Requires the [data] parameter representing the successful data result.
  const DataSuccess(T data) : super(data: data);
}

/// Represents a failed data state due to an error.
///
/// This is a concrete subclass of [DataState].
class DataFailed<T> extends DataState<T> {
  /// Creates a new instance of [DataFailed].
  ///
  /// Requires the [error] parameter representing the error that occurred.
  const DataFailed(DioError error) : super(error: error);
}
