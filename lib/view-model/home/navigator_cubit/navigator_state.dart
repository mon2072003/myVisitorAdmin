part of 'navigator_cubit.dart';

sealed class NavigatorStates {
  int currentIndex;
  NavigatorStates({required this.currentIndex});
}

final class NavigatorInitial extends NavigatorStates {
  NavigatorInitial() : super(currentIndex: 0);
}

final class NavigatorChangeState extends NavigatorStates {
  NavigatorChangeState({required super.currentIndex});
}