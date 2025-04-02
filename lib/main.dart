import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lottie/lottie.dart';
import 'package:news/auth/login.dart';
import 'package:news/auth/reset.dart';
import 'package:news/auth/signup.dart';
import 'package:news/auth/verify.dart';
import 'package:news/services/auth.dart';
import 'package:news/view/homeScreen.dart';
import 'package:news/view/splash.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/auth/reset.dart';
import 'package:news/auth/signup.dart';
import 'package:news/auth/verify.dart';
import 'package:news/view/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
      home:
          // HomeScreen(),
          AnimatedSplashScreen(
        splash: Lottie.asset(
            'assets/lotti/Splash.json'), // Replace with your Lottie animation or image path
        splashIconSize: 250,
        nextScreen:
            const AuthDecider(), // Determine the next screen based on user state
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.pink, // Customize the background color
        duration: 10000, // Duration in milliseconds
      ),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          middlewares: [AuthGuard()],
        ),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/reset', page: () => const ResetScreen()),
        GetPage(name: '/verify', page: () => const VerifyScreen()),
      ],
    );
  }
}

class AuthDecider extends StatelessWidget {
  const AuthDecider({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    if (authController.user.value != null) {
      return const HomeScreen(); // Navigate to HomeScreen if logged in
    } else {
      return const LoginScreen(); // Navigate to LoginScreen if not logged in
    }
  }
}

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    return authController.user.value == null
        ? const RouteSettings(name: '/login')
        : null;
  }
}
