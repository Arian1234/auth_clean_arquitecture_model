import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<User?> getUserAuth();
  Future<User?> getUserStatus({String? email, String? pass});
  Future<User?> setUserCreate({required String email, required String pass});
}
