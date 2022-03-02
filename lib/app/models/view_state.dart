abstract class ViewState {}

class ViewStateIdle implements ViewState {}

class ViewStateSucess<T> implements ViewState {
  T state;
  ViewStateSucess(this.state);
}
