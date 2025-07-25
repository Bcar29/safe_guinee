import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_guinee/controllers/theme_controller.dart';
import 'package:safe_guinee/firebase_options.dart';
import 'package:safe_guinee/ui/screen/account_screen.dart';
import 'package:safe_guinee/ui/screen/home_screen.dart';
import 'package:safe_guinee/utils/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isdark = Provider.of<ThemeController>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Guinée',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: (isdark.theme ? ThemeMode.light: ThemeMode.dark),
      home: HomeScreen(),
    );
  }
}
