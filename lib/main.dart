import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/app_router.dart';
import 'package:medcs/core/utlity/themes.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(), // Instantiate ThemeProvider with create
      ),
      ChangeNotifierProvider(
        create: (_) =>
            ProductProvider(), // Instantiate ThemeProvider with create
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute.router,
      theme: themeProvider.isDarkMode
          ? ThemeManager.darkTheme()
          : ThemeManager.lightTheme(),
    );
  }
}
