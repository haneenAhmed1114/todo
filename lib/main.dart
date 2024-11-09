import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/modules/authontication/provider/auth_provider.dart';
import 'package:todo_application/modules/authontication/view/login_screen.dart';
import 'package:todo_application/modules/authontication/view/signUp_screen.dart';
import 'package:todo_application/modules/home_screen/edit_screen.dart';
import 'package:todo_application/modules/home_screen/home_screen.dart';
import 'package:todo_application/modules/splash/splash_screen.dart';
import 'package:todo_application/shared/provider/theme_provider.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';
import 'package:todo_application/shared/utils/app_theme.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings=const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TaskProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => localAuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).appThemeMode,
      locale: Locale(Provider.of<ThemeProvider>(context).localCode),
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        SignupScreen.routeName: (_) => SignupScreen(),
        EditScreen.routeName: (context) {
          final task = ModalRoute.of(context)?.settings.arguments as TaskModel?;
          if (task == null) {
            // Handle the case when no task is provided
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(child: Text('No task data provided.')),
            );
          }
          return EditScreen(task: task); // Pass the valid task to EditScreen
        },
      },
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
    );
  }
}
