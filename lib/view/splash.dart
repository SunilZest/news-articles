// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:news/view/homeScreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to the HomeScreen after 3 seconds
//     // Future.delayed(const Duration(seconds: 3), () {
//     //   Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(builder: (context) => const HomeScreen()),
//     //   );
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.pink, Colors.red, Colors.white],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           // Lottie animation
//           Center(
//             child: Lottie.asset(
//               'assets/lotti/Splash.json',
//               fit: BoxFit.contain,
//             ),
//           ),
//           // App name or logo
//           const Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Text(
//                   'News App',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Stay updated with the latest news',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
