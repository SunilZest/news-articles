import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static const String projectId = '67e3f8b70021de1f6633'; // Your Appwrite project ID
  static const String endpoint = 'https://cloud.appwrite.io/v1'; // Appwrite endpoint

  static Client get client {
    Client client = Client();
    client
        .setEndpoint(endpoint)
        .setProject(projectId)
        .setSelfSigned(status: true); // For self-signed certificates in development
    return client;
  }

  static Account get account => Account(client);
  // static Storage get storage => Storage(client);
  // static Databases get databases => Databases(client);
}