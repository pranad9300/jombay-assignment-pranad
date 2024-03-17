abstract class Failure {
  final String? message;

  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure({
    this.message,
  });
}

class HttpFailure extends Failure {
  HttpFailure({
    super.message,
  });
}

class NoInternetFailure extends Failure {
  NoInternetFailure({super.message = 'Please check your Internet connection.'});
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message = 'Something went wrong, please try again.'});
}
