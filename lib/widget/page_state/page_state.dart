class PageState {}

class LoadingState extends PageState {
  String message;

  LoadingState({this.message = 'loading'});
}

class EmptyState extends PageState {
  String message;

  EmptyState({this.message = 'page is empty'});
}

class ErrorState extends PageState {
  String message;

  ErrorState({this.message = 'page error'});
}

class NetworkErrorState extends ErrorState {

  NetworkErrorState({String message = 'network error'}): super(message: message);
}

class SuccessState<Model> extends PageState {
  Model model;

  SuccessState({this.model});
}