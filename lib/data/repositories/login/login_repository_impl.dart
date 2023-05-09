import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/domain/repositories/login_repository.dart';

class LoginRepositoryImplement extends LoginRepository {
  final FirebaseAuth _firebaseAuth;
  final Completer<void> _completer = Completer();
  // User Status
  User? _user;
  User? _userStatus;
  User? _userCreate;
  UserCredential? verified;
  UserCredential? credential;

  LoginRepositoryImplement(this._firebaseAuth) {
    _init();
  }

  void _init() async {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }

  void getStatus(String email, String pass) async {
    try {
      verified = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }

    _userStatus = verified?.user;
  }

  Future<void> setCreate(String email, String pass) async {
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.',
            name: 'login_repository_impl');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.',
            name: 'login_repository_impl');
      }
    } catch (e) {
      log(e.toString());
    }
    _userCreate = credential?.user;
  }

  @override
  Future<User?> getUserAuth() async {
    log('Consultando getUserAuth', name: '✔️login_repository_impl');
    await _completer.future;
    return _user;
  }

  @override
  Future<User?> getUserStatus({String? email, String? pass}) async {
    log('Consultando getUserStatus', name: '✔️login_repository_impl');
    getStatus(email ?? '', pass ?? '');
    return _userStatus;
  }

  @override
  Future<User?> setUserCreate(
      {required String email, required String pass}) async {
    log('Registrando getUserCreate', name: '✔️login_repository_impl');
    setCreate(email, pass);
    return _userCreate;
  }
}
