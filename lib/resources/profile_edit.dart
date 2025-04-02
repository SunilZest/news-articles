import 'dart:io'; // Import File for image handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

void showProfileEditDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ProfileEditDialog());
    },
  );
}

class ProfileEditDialog extends StatefulWidget {
  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _singerController = TextEditingController();
  final TextEditingController _toyController = TextEditingController();
  File? _image; // Variable to hold the selected image

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery, // You can choose ImageSource.camera for camera option
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); // Convert XFile to File
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog( // Use Dialog instead of AlertDialog for better control over width
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Set width here
        padding: const EdgeInsets.all(16), // Add padding
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit, color: Colors.teal, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.camera_alt, color: Colors.white, size: 40)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(controller: _firstNameController, label: 'First Name', validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _lastNameController, label: 'Last Name', validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _dobController, label: 'Date of Birth', validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _emailController, label: 'Email', validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _singerController, label: 'Favorite Singer', validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your favorite singer';
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _toyController, label: 'Favorite Toy', validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your favorite toy';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated')));
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.teal.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          ),
                          child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel", style: TextStyle(color: Colors.teal.shade900)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     backgroundColor: Colors.teal.shade50,
  //     title: Row(
  //       children: [
  //         const Icon(Icons.edit, color: Colors.teal, size: 28),
  //         const SizedBox(width: 10),
  //         Text(
  //           "Edit Profile",
  //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900, fontSize: 18),
  //         ),
  //       ],
  //     ),
  //     content: SingleChildScrollView(
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Profile Image Display and Change Option
  //             GestureDetector(
  //               onTap: _pickImage, // Open image picker when tapped
  //               child: CircleAvatar(
  //                 radius: 50,
  //                 backgroundColor: Colors.grey.shade300,
  //                 backgroundImage: _image != null ? FileImage(_image!) : null,
  //                 child: _image == null
  //                     ? const Icon(Icons.camera_alt, color: Colors.white, size: 40)
  //                     : null, // Display camera icon if no image selected
  //               ),
  //             ),
  //             const SizedBox(height: 15),
  //
  //             _buildTextField(
  //               controller: _firstNameController,
  //               label: 'First Name',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your first name';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             _buildTextField(
  //               controller: _lastNameController,
  //               label: 'Last Name',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your last name';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             _buildTextField(
  //               controller: _dobController,
  //               label: 'Date of Birth',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your date of birth';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             _buildTextField(
  //               controller: _emailController,
  //               label: 'Email',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
  //                   return 'Please enter a valid email';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             _buildTextField(
  //               controller: _singerController,
  //               label: 'Favorite Singer',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your favorite singer';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             _buildTextField(
  //               controller: _toyController,
  //               label: 'Favorite Toy',
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your favorite toy';
  //                 }
  //                 return null;
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           if (_formKey.currentState?.validate() ?? false) {
  //             // Handle the profile update logic
  //             Navigator.pop(context);
  //             // You can handle form data here, like saving it to a database or updating UI
  //             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated')));
  //           }
  //         },
  //         style: TextButton.styleFrom(
  //             backgroundColor: Colors.teal.shade600,
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
  //         child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  //       ),
  //       TextButton(
  //         onPressed: () => Navigator.pop(context),
  //         child: Text("Cancel", style: TextStyle(color: Colors.teal.shade900)),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      validator: validator,
    );
  }
}

