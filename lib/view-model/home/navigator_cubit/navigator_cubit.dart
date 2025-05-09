import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorStates> {
  NavigatorCubit() : super(NavigatorInitial());

  void changeIndex(int index) {
    emit(NavigatorChangeState(currentIndex: index));
  }
  void resetIndex() {
    emit(NavigatorInitial());
  }
  int getCurrentIndex() {
    return state.currentIndex;
  }
}
