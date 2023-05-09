import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/UI/providers/login/login_provider.dart';
import 'package:flutter_authentication/data/repositories/login/login_repository_impl.dart';
import 'package:get_it/get_it.dart';

final _injector = GetIt.instance;
void setUp() {
  _injector.registerLazySingleton<LoginRepositoryImplement>(
      () => LoginRepositoryImplement(FirebaseAuth.instance));

  // _injector.registerLazySingleton<LoginController>(
  //     () => LoginController(_injector<LoginRepositoryImplement>()));
  _injector.registerLazySingleton<LoginProvider>(
      () => LoginProvider(_injector<LoginRepositoryImplement>()));
}
