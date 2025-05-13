import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorStates> {
  NavigatorCubit() : super(NavigatorInitial());
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(NavigatorChangeState(currentIndex: index));
  }
  void resetIndex() {
    currentIndex = 0;
    emit(NavigatorInitial());
  }
  int getCurrentIndex() {
    return state.currentIndex;
  }
}
