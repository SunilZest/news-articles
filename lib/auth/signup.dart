import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/auth/login.dart';
import 'package:news/resources/constants.dart';
import 'package:news/services/auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              child: Form(
                key: _formKey, // Add form key
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.3),
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
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
                        children: [
                          _buildAnimatedTextField(
                            controller: _nameController,
                            labelText: 'Name',
                            icon: Icons.person,
                            color: Colors.purple,
                          ),
                          const SizedBox(height: 8),
                          _buildAnimatedTextField(
                            controller: _emailController,
                            labelText: 'Email',
                            icon: Icons.email,
                            color: Colors.blue,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 8),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade300,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: authController.isLoading.value
                          ? null
                          : _signup, // Disable button if loading
                      child: Obx(
                        () => authController.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text('SignUp'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'LogIn',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialLoginButton(ConstantImage.fbIcon),
                        const SizedBox(width: 20),
                        socialLoginButton(ConstantImage.googleIcon),
                        const SizedBox(width: 20),
                        socialLoginButton(ConstantImage.git),
                      ],
                    ),
            
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      authController.signUp(
        name:_nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
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
          final emailRegex =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
