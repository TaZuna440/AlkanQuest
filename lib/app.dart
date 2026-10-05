import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_screen.dart';

class IponApp extends StatelessWidget {
  const IponApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ipon System',
      debugShowCheckedModeBanner: false,
      theme: buildIponTheme(),
      home: const HomeScreen(),
    );
  }
}
