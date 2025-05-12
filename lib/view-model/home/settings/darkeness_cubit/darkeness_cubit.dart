import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'darkeness_state.dart';

class DarkenessCubit extends Cubit<DarkenessState> {
  DarkenessCubit() : super(DarkenessInitial());
  Box darkenessBox = Hive.box('darkeness');
  void setDarkeness(bool darkeness) {
    darkenessBox.put('darkeness', darkeness);
    emit(DarkenessChanged(darkeness: darkeness));
  }
  void getDarkeness() {
  bool darkeness = darkenessBox.get('darkeness');
  emit(DarkenessChanged(darkeness: darkeness));
  }
}
