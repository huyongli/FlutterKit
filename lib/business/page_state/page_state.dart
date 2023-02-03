import 'package:laohu_kit/business/page_state/page_widget.dart';

class DataState {}

class IdleState extends DataState {

}
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

  ErrorState({this.message = 'Page error'});
}

class NetworkErrorState extends ErrorState {
  NetworkErrorState({String message = 'Network error'}) : super(message: message);
}

class SuccessState<Model> extends DataState {
  Model? model;

  SuccessState({this.model});
}

extension PageStateExt on DataState {
  PageStateType get toPageStateType {
    if (this is EmptyState) {
      return PageStateType.empty;
    }
    if (this is ErrorState) {
      return PageStateType.error;
    }
    if (this is NetworkErrorState) {
      return PageStateType.networkError;
    }
    if (this is LoadingState) {
      return PageStateType.loading;
    }
    return PageStateType.gone;
  }
}