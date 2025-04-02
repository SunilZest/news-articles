import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/resources/constants.dart';
import 'package:news/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  bool rememberMe = false;
  bool _isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Call your authController login function here
      authController.login(
        // name: _emailController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.3),
                  const Text(
                    'LogIn',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnimatedTextField(
                            controller: _emailController,
                            labelText: 'Email',
                            icon: Icons.email,
                            color: Colors.blue,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: size.height * 0.02),
                          _buildPasswordField(
                            controller: _passwordController,
                            labelText: 'Password',
                            isVisible: _isPasswordVisible,
                            toggleVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: Size(double.infinity, size.height * 0.07),
                    ),
                    onPressed: _login,
                    child: Obx(
                          () => authController.isLoading.value
                          ? SizedBox(
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : const Text('LogIn'),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                          text: 'Create an Account',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Forgot Password? ',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                          text: 'Reset it.',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/reset');
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialLoginButton(ConstantImage.fbIcon),
                      SizedBox(width: size.width * 0.05),
                      socialLoginButton(ConstantImage.googleIcon),
                      SizedBox(width: size.width * 0.05),
                      socialLoginButton(ConstantImage.git),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         Container(
  //           decoration: const BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [Colors.pink, Colors.white],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //           ),
  //         ),
  //         ClipPath(
  //           clipper: WaveClipper(),
  //           child: Container(
  //             height: MediaQuery.of(context).size.height * 0.45,
  //             decoration: const BoxDecoration(
  //               color: Colors.pink,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
  //           child: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const Text(
  //                   'LogIn',
  //                   style: TextStyle(
  //                     fontSize: 32,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 40),
  //                 Form(
  //                   key: _formKey,
  //                   child: Container(
  //                     padding: const EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(16),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black.withOpacity(0.1),
  //                           blurRadius: 10,
  //                           spreadRadius: 5,
  //                         ),
  //                       ],
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         _buildAnimatedTextField(
  //                           controller: _emailController,
  //                           labelText: 'Email',
  //                           icon: Icons.email,
  //                           color: Colors.blue,
  //                           keyboardType: TextInputType.emailAddress,
  //                         ),
  //                         const SizedBox(height: 8),
  //                         _buildPasswordField(
  //                           controller: _passwordController,
  //                           labelText: 'Password',
  //                           isVisible: _isPasswordVisible,
  //                           toggleVisibility: () {
  //                             setState(() {
  //                               _isPasswordVisible = !_isPasswordVisible;
  //                             });
  //                           },
  //                         ),
  //                         const SizedBox(height: 4),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.pink.shade300,
  //                     foregroundColor: Colors.white,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(16),
  //                     ),
  //                     minimumSize: const Size(double.infinity, 50),
  //                   ),
  //                   onPressed: _login, // Disable button if loading
  //                   child: Obx(
  //                     () => authController.isLoading.value
  //                         ? const SizedBox(
  //                             height: 24,
  //                             width: 24,
  //                             child: CircularProgressIndicator(
  //                               color: Colors.white,
  //                               strokeWidth: 2.5,
  //                             ),
  //                           )
  //                         : const Text('LogIn'),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 RichText(
  //                   text: TextSpan(
  //                     text: "Don't have an account? ",
  //                     style: const TextStyle(color: Colors.black, fontSize: 14),
  //                     children: [
  //                       TextSpan(
  //                         text: 'Create an Account',
  //                         style: const TextStyle(
  //                           color: Colors.blue,
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           decoration: TextDecoration.underline,
  //                         ),
  //                         recognizer: TapGestureRecognizer()
  //                           ..onTap = () {
  //                             Navigator.pushNamed(context, '/signup');
  //                           },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 RichText(
  //                   text: TextSpan(
  //                     text: 'Forgot Password? ',
  //                     style: const TextStyle(color: Colors.black, fontSize: 14),
  //                     children: [
  //                       TextSpan(
  //                         text: 'Reset it.',
  //                         style: const TextStyle(
  //                           color: Colors.blue,
  //                           decoration: TextDecoration.underline,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 14,
  //                         ),
  //                         recognizer: TapGestureRecognizer()
  //                           ..onTap = () {
  //                             Navigator.pushNamed(context, '/reset');
  //                           },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     socialLoginButton(ConstantImage.fbIcon),
  //                     const SizedBox(width: 20),
  //                     socialLoginButton(ConstantImage.googleIcon),
  //                     const SizedBox(width: 20),
  //                     socialLoginButton(ConstantImage.git),
  //                   ],
  //                 ),
  //                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

Widget _buildAnimatedTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  required Color color,
  TextInputType keyboardType = TextInputType.text,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.2),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(icon, color: color),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (labelText == 'Password') {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
        } else if (labelText == 'Email') {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Enter a valid email address';
          }
        } else {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
        }
        return null;
      },
    ),
  );
}

Widget _buildPasswordField({
  required TextEditingController controller,
  required String labelText,
  required bool isVisible,
  required VoidCallback toggleVisibility,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.lock, color: Colors.red),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    ),
  );
}

Widget socialLoginButton(String assetPath) {
  return GestureDetector(
    onTap: () {
      // Handle social login action
    },
    child: CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      child: Image.asset(
        assetPath,
        width: 50,
        height: 50,
      ),
    ),
  );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 100);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 160, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
