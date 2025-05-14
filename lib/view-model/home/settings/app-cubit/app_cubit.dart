import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  bool darkeness = Hive.box('darkeness').get('darkeness') ?? true;
  String language = Hive.box('language').get('language') ?? "en";
  
  void setDarkeness(bool darkeness) async{
    await Hive.box('darkeness').put('darkeness', darkeness);
    this.darkeness = darkeness;
    emit(AppChanged(darkeness: darkeness,language: language));
  }
  void getDarkeness() {
    bool darkeness = Hive.box('darkeness').get('darkeness') ?? true;
    this.darkeness = darkeness;
    emit(AppChanged(darkeness: darkeness,language: language));
  }
  void setLanguage(String language) async{
    await Hive.box('language').put('language', language);
    this.language = language;
    emit(AppChanged(darkeness: darkeness,language: language));
  }
  void getLanguage() {
    String language = Hive.box('language').get('language') ?? "en";
    this.language = language;
    emit(AppChanged(darkeness: darkeness,language: language));
  }
}
