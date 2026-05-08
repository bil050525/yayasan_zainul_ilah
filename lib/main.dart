import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const YayasanApp());
}

class YayasanApp extends StatelessWidget {
  const YayasanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yayasan Zainul Ilah',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
