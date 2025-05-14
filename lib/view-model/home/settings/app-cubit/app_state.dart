part of 'app_cubit.dart';

sealed class AppState {
  bool darkeness;
  String language;
  AppState({required this.darkeness, required this.language});
}

final class AppInitial extends AppState {
  AppInitial()
    : super(
        darkeness: Hive.box('darkeness').get('darkeness') ?? true,
        language: Hive.box('language').get('language') ?? 'en',
      );
}

final class AppChanged extends AppState {
  AppChanged({required super.darkeness, required super.language});
}
