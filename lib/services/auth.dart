import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:news/services/AppwriteService.dart';

class AuthController extends GetxController {
  final _account = AppwriteService.account;
  final Rx<User?> user = Rx<User?>(null);
  late RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      isLoading.value = true;
      final currentUser = await _account.get();
      user.value = currentUser;
      if (Get.currentRoute == '/login' || Get.currentRoute == '/signup') {
        Get.offAllNamed('/');
      }
    } catch (e) {
      user.value = null;
      if (Get.currentRoute != '/login' && Get.currentRoute != '/signup') {
        Get.offAllNamed('/signup');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> signUp({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   print('Email: ${email}');
  //   print('Password: ${password}');
  //   try {
  //     isLoading.value = true;
  //     var response = await _account.create(
  //       userId: ID.unique(),
  //       name: name,
  //       email: email,
  //       password: password,
  //     );
  //     print('response data: ${response.toString()}');
  //     await login(email: email, password: password);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    print('Email: $email');
    print('Password: $password');
    try {
      isLoading.value = true;

      // Retrieve the session ID of the currently logged-in user
      const defaultSessionId =
          'current'; // Replace 'current' with the actual session ID logic for your app.
      try {
        var currentSession =
            await _account.getSession(sessionId: defaultSessionId);

        // If a session exists, delete it
        if (currentSession != null) {
          await _account.deleteSession(sessionId: currentSession.$id);
          print('Existing session cleared.');
        }
      } catch (e) {
        print('No active session found: $e');
      }

      // Create a new user account
      var response = await _account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );
      print('Response data: ${response.toString()}');

      // Automatically log in the user after signup
      await login(email: email, password: password);
    } catch (e) {
      if (e.toString().contains('already exists')) {
        Get.snackbar(
          'Account Error',
          'An account with this email already exists. Please log in.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
      print('Email: ${email}');
      print('Password: ${password}');
    try {
      isLoading.value = true;
      // Retrieve the session ID of the currently logged-in user
      const defaultSessionId = 'current'; // Replace 'current' with the actual session ID logic for your app.
      try {
        var currentSession =
        await _account.getSession(sessionId: defaultSessionId);

        // If a session exists, delete it
        if (currentSession != null) {
          await _account.deleteSession(sessionId: currentSession.$id);
          print('Existing session cleared.');
        }
      } catch (e) {
        print('No active session found: $e');
      }

      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      await checkAuth();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _account.deleteSession(sessionId: 'current');
      user.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
