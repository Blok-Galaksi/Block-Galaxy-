import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

class GalaxyApp extends StatelessWidget {
  const GalaxyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
