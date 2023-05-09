import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/data/repositories/login/login_repository_impl.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepositoryImplement _loginRepositoryImplement;

  LoginProvider(this._loginRepositoryImplement);

  Future<User?> getUserAuth() async {
    log('Ingrese al metodo getUserAuth', name: '✔️login_provider');
    try {
      User? userData = await _loginRepositoryImplement.getUserAuth();
      log('Devolviendo el modelo User?', name: '✔️login_provider');
      return userData;
    } catch (e) {
      log('Error message, tenemos problemas. $e', name: '⚠️login_provider');
    } finally {
      notifyListeners();
    }

    throw ErrorDescription('Acaba de suceder un error');
  }

  Future<User?> getUserStatus({String? email, String? pass}) async {
    log('Ingrese al metodo getUserStatus', name: '✔️login_provider');
    try {
      User? userData = await _loginRepositoryImplement.getUserStatus(
          email: email, pass: pass);
      log('Devolviendo el modelo User?', name: '✔️login_provider');
      return userData;
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
    throw ErrorDescription('Acaba de suceder un error');
  }

  Future<User?> getUserCreate(
      {required String email, required String pass}) async {
    try {
      log('Ingrese al metodo getUserCreate', name: 'login_provider');
      User? user = await _loginRepositoryImplement.setUserCreate(
          email: email, pass: pass);
      return user;
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
    throw ErrorDescription('Se me acaba de pasar un error.');
  }
}
