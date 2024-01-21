/// Represents an abstract class for a use case. All use cases should extend from this class.
///
/// The [Type] parameter represents the return type of the use case.
/// The [Params] parameter represents the parameters required for the use case.
abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}
