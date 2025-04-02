import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/resources/Pp.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/permison_box.dart';
import 'package:news/resources/profile_edit.dart';
import 'package:news/services/auth.dart';
import 'package:news/view/chatBox/chat_screen.dart';

final AuthController authController = Get.find<AuthController>();
// import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  final List<DrawerItem> drawerItems = [
    DrawerItem(
      image: ConstantImage.yolo,
      title: 'Profile',
      subtitle: 'Modifying user account details.',
      onTap: (context) {
        showProfileEditDialog(context);
      },
      color: Colors.pink,
    ),
    DrawerItem(
      image: ConstantImage.yolo,
      title: 'Settings',
      subtitle: 'Configurations or customization options.',
      onTap: (context) {
        showPermissionDialog(context);
      },
      color: Colors.deepOrange,
    ),
    DrawerItem(
      image: ConstantImage.yolo,
      title: 'Privacy Policy',
      subtitle: 'Rules on personal data usage.',
      onTap: (context) {
        showPolicyDialog(context);
      },
      color: Colors.green,
    ),
    DrawerItem(
      image: ConstantImage.yolo,
      title: 'Terms and Conditions',
      subtitle: 'Rules and agreements for usage.',
      onTap: (context) {
        showPolicyDialog(context);
      },
      color: Colors.red,
    ),
    DrawerItem(
      image: ConstantImage.yolo,
      title: 'Help ChatBox',
      subtitle: 'Support chat for user assistance.',
      onTap: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
      color: Colors.blue,
    ),
    DrawerItem(
      image: ConstantImage.logout,
      title: 'Logout',
      subtitle: 'Sign out of your account.',
      onTap: (context) {
        authController.logout();
      },
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedCard(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white!, Colors.teal[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView.separated(
                shrinkWrap:
                    true, // Ensures ListView does not take infinite height
                physics:
                    NeverScrollableScrollPhysics(), // Disables ListView's internal scrolling
                padding: EdgeInsets.zero,
                itemCount: drawerItems.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 8,
                ),
                itemBuilder: (context, index) {
                  return drawerItems[index].build(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final String image;
  final String title;
  final String? subtitle;
  final Color color;
  final Function(BuildContext) onTap;

  DrawerItem({
    required this.image,
    required this.title,
    this.subtitle,
    required this.color,
    required this.onTap,
  });

  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(image),
        backgroundColor: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[600]!, Colors.teal[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                subtitle!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            )
          : null,
      onTap: () => onTap(context),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey.shade600),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white!, Colors.teal[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user, size: 50, color: Colors.pink),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello!",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.pink,
                      ),
                    ),
                    const Text(
                      "User Name. Good Morning !",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                    const SizedBox(height: 12),
                    // const Text("Add New Blog"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
