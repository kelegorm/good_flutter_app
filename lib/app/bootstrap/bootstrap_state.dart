sealed class BootstrapState {
  const BootstrapState();
}

class BootstrapLoading extends BootstrapState {
  const BootstrapLoading();
}

class BootstrapComplete extends BootstrapState {
  const BootstrapComplete();
}

class BootstrapError extends BootstrapState {
  final String message;

  const BootstrapError(this.message);
}
