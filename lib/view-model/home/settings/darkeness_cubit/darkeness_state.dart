part of 'darkeness_cubit.dart';

sealed class DarkenessState {
  bool darkeness;
  DarkenessState({required this.darkeness});
}

final class DarkenessInitial extends DarkenessState {
  DarkenessInitial():super(darkeness: Hive.box('darkeness').get('darkeness') ?? true);
}
final class DarkenessChanged extends DarkenessState {
  DarkenessChanged({required super.darkeness});
}
