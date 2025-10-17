import 'package:flutter/material.dart';
import 'package:lodo_app/screens/loading_screen.dart';
import 'package:lodo_app/screens/match_screen.dart';
import 'package:lodo_app/utils/app_colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const LudoKingClone());
}

class LudoKingClone extends StatelessWidget {
  const LudoKingClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ludo King Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/finding': (context) => const FindingMatchScreen(),
        '/match': (context) => const MatchScreen(),
      },
    );
  }
}
