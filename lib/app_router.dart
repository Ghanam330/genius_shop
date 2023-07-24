import 'package:flutter/material.dart';
import 'package:genius_shop/screens/auth_ui/splach/splash_screen.dart';
import 'package:genius_shop/screens/change_password/change_password.dart';
import 'package:genius_shop/screens/home/tap_screen.dart';
import 'constants/strings.dart';
import 'screens/auth_ui/login/login_screen.dart';
import 'screens/auth_ui/sign_up/signup_screen.dart';
import 'screens/auth_ui/splach/intro_screen.dart';
import 'screens/auth_ui/splach/landing_screen.dart';




class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
     case resetPasswordScreen:
       return MaterialPageRoute(builder: (_) => PasswordResetScreen());
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => TabScreen(),
        );
      case landingScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen());

    }
  }
}

