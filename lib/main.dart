import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:flutter_movie_app/enums/theme_enums.dart';
import 'package:flutter_movie_app/screens/splash_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await dotenv.load();

    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: themeState == ThemeEnums.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
