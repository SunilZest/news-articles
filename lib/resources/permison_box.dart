import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionDialog(BuildContext context) {
  bool enableContacts = false;
  bool enableGallery = false;
  bool enableLocation = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.teal.shade50, // Light Teal Background
            title: Row(
              children: [
                Icon(Icons.security, color: Colors.teal, size: 28),
                SizedBox(width: 10),
                Text(
                  "App Permissions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                      fontSize: 18),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select the permissions you want to enable:",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),

                _buildPermissionToggle(
                    Icons.contacts, "Contacts Access", enableContacts, (value) {
                  setState(() {
                    enableContacts = value;
                  });
                }),

                _buildPermissionToggle(
                    Icons.photo, "Gallery Access", enableGallery, (value) {
                  setState(() {
                    enableGallery = value;
                  });
                }),

                _buildPermissionToggle(
                    Icons.location_on, "Location Access", enableLocation, (value) {
                  setState(() {
                    enableLocation = value;
                  });
                }),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await requestSelectedPermissions(
                      enableContacts, enableGallery, enableLocation);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                child: Text("Apply",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: Colors.teal.shade900)),
              ),
            ],
          );
        },
      );
    },
  );
}

// Function to request only selected permissions
Future<void> requestSelectedPermissions(bool contacts, bool gallery, bool location) async {
  List<Permission> permissionsToRequest = [];

  if (contacts) permissionsToRequest.add(Permission.contacts);
  if (gallery) permissionsToRequest.add(Permission.storage);
  if (location) permissionsToRequest.add(Permission.location);

  if (permissionsToRequest.isNotEmpty) {
    await permissionsToRequest.request();
  }
}

// Helper function to create a toggle switch for permissions
Widget _buildPermissionToggle(IconData icon, String title, bool value, Function(bool) onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.teal.shade700, size: 22),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green.shade600,
        ),
      ],
    ),
  );
}
