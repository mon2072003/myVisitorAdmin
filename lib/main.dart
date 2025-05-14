import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/view-model/home/settings/app-cubit/app_cubit.dart';
import 'package:my_visitor_admin/view/home/settings/change-password/change_password_screen.dart';
import 'package:my_visitor_admin/view/home/about-us/about_us_screen.dart';
import 'package:my_visitor_admin/view/home/chats/chat_view.dart';
import 'package:my_visitor_admin/view/home/chats/contacts_support_view.dart';
import 'package:my_visitor_admin/view/auth/forgot_password_screen.dart';
import 'package:my_visitor_admin/view/auth/login_screen.dart';
import 'package:my_visitor_admin/view/home/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_visitor_admin/view/home/notifications/send_notifications_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://crgwwfzifppleytrqcmh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNyZ3d3ZnppZnBwbGV5dHJxY21oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMjI0MzksImV4cCI6MjA1NDc5ODQzOX0.cjC38O9-YnZ916IaZDQXee4ONfdnV3Fy14ymnpOAZ4c',
  );
  await setupHive();
  runApp(const MyVisitorAdmin());
}

class MyVisitorAdmin extends StatelessWidget {
  const MyVisitorAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is AppInitial) {
            context.read<AppCubit>().getDarkeness();
            context.read<AppCubit>().getLanguage();
          }
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(state.language),
            debugShowCheckedModeBanner: false,
            title: 'My Visitor Admin',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: state.darkeness ? Brightness.dark : Brightness.light,
              fontFamily: 'Schyler',
            ),
            initialRoute:
                FirebaseAuth.instance.currentUser?.email == null
                    ? '/login'
                    : '/home',
            routes: routes,
            onGenerateRoute: (settings) {
              if (settings.name == ChatView.id) {
                final contactEmail = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => ChatView(contactEmail: contactEmail),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => HomeScreen(),
  '/forgot-password': (context) => ForgotPasswordScreen(),
  '/login': (context) => LoginScreen(),
  '/ContactsSupportScreen': (context) => ContactsSupportScreen(),
  '/SendNotifactionsSendView': (context) => SendNotifactionsSendView(),
  '/change-password': (context) => ChangePasswordScreen(),
  '/about-us': (context) => AboutUsScreen(),
};

Future<void> setupHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('darkeness');
  await Hive.openBox('language');
  
  var box = Hive.box('darkeness');
  var languageBox = Hive.box('language');
  
  if (!languageBox.containsKey('language')) {
    await languageBox.put('language', 'en');
  }

  if (!box.containsKey('darkeness')) {
    await box.put('darkeness', true);
  }
}