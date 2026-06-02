import 'package:flutter/material.dart';
import 'package:mobile/core/constants/routes.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/presentation/User/Home.page.dart';
import 'package:mobile/presentation/screens/auth/sign_in_page.dart';
import 'package:mobile/presentation/screens/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.authSignIn: (context) => const SignInPage(),
        AppRoutes.authSignUp: (context) => const RegisterScreen(),
      },
      title: 'S.E.A System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const HomePage(),
    );
  }
}
