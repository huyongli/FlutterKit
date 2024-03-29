import 'package:laohu_kit/business/page_state/page_widget.dart';

class DataState {}

class IdleState extends DataState {}

class LoadingState extends DataState {
  String message;

  LoadingState({this.message = 'loading'});
}

class EmptyState extends DataState {
  String message;

  EmptyState({this.message = 'Page is empty'});
}

class ErrorState extends DataState {
  String message;
  Error? exception;

  ErrorState({this.message = 'Page error', this.exception});
}

class NetworkErrorState extends ErrorState {
  NetworkErrorState({String message = 'Network error'}) : super(message: message);
}

class SuccessState<Model> extends DataState {
  Model? model;

  SuccessState({this.model});
}

extension PageStateExt on DataState {
  PageState get toPageStateType {
    if (this is EmptyState) {
      return PageState.empty;
    }
    if (this is ErrorState) {
      return PageState.error;
    }
    if (this is NetworkErrorState) {
      return PageState.networkError;
    }
    if (this is LoadingState) {
      return PageState.loading;
    }
    return PageState.gone;
  }
}
