enum DisplayType { fullScreen, popUpDialog }

abstract class BaseState {
  final DisplayType displayType;
  BaseState({this.displayType = DisplayType.fullScreen});
}

class InitialState extends BaseState {}

class LoadingState extends BaseState {
  LoadingState({super.displayType});
}

class SuccessState extends BaseState {
  final String message;
  SuccessState(this.message);
}

class EmptyState extends BaseState {
  final String? message;

  EmptyState({
    super.displayType,
    this.retry,
    this.message,
  });

  final void Function()? retry;
}

class ErrorState extends BaseState {
  final String errorMessage;

  ErrorState(
    this.errorMessage,
  );
}

class ContentState extends BaseState {}
