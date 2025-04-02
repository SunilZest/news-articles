import 'package:flutter/material.dart';

void showPolicyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PrivacyPolicyDialog(); // Show the dialog using the StatefulWidget
    },
  );
}

class PrivacyPolicyDialog extends StatefulWidget {
  @override
  _PrivacyPolicyDialogState createState() => _PrivacyPolicyDialogState();
}

class _PrivacyPolicyDialogState extends State<PrivacyPolicyDialog> {
  bool isAgreed = false; // Initial state for the checkbox

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.teal.shade50, // Light Teal Background
      title: Row(
        children: [
          const Icon(Icons.privacy_tip, color: Colors.teal, size: 28),
          const SizedBox(width: 10),
          Text(
            "Privacy Policy & Terms",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
                fontSize: 18),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Please read and accept our Privacy Policy and Terms & Conditions.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // Privacy Policy Text
            InkWell(
              onTap: () {
                showFullTextDialog(context, "Privacy Policy", privacyText);
              },
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.teal.shade700, size: 22),
                  const SizedBox(width: 10),
                  Text("Privacy Policy",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal.shade800)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Terms & Conditions Text
            InkWell(
              onTap: () {
                showFullTextDialog(context, "Terms & Conditions", termsText);
              },
              child: Row(
                children: [
                  Icon(Icons.description, color: Colors.teal.shade700, size: 22),
                  const SizedBox(width: 10),
                  Text("Terms & Conditions",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal.shade800)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Align checkbox to the left and fix vertical alignment issue
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align checkbox vertically to the top
              children: [
                Checkbox(
                  value: isAgreed,
                  onChanged: (value) {
                    setState(() {
                      isAgreed = value ?? false; // Update checkbox state
                    });
                  },
                  activeColor: Colors.green.shade600,
                ),
                const Expanded(
                  child: Text(
                    "I Agree to the Terms & Privacy Policy",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isAgreed
              ? () {
            Navigator.pop(context);
            // Perform any action after agreeing, e.g., navigate to the next screen
          }
              : null,
          style: TextButton.styleFrom(
              backgroundColor: isAgreed ? Colors.green.shade600 : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          child: const Text("Accept",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.teal.shade900)),
        ),
      ],
    );
  }

  // Function to Show Full Privacy or Terms Content in a New Dialog
  void showFullTextDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
          content: SingleChildScrollView(
            child: Text(content, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: Colors.teal.shade900)),
            ),
          ],
        );
      },
    );
  }
}

// Sample Privacy Policy & Terms Text
const String privacyText = """Your privacy is important to us. We collect and use your data responsibly. Our policy ensures that we respect your privacy and give you control over your information. We do not share your personal data with third parties without your consent, except as required by law.""";

const String termsText = """By using this website or app, you agree to our Terms and Conditions. You are responsible for keeping your account details safe and using the website in a lawful manner. We reserve the right to modify or terminate services at our discretion. Please read carefully.""";
