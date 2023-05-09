import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../providers/login/login_provider.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusAuth = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    log('consulto');
                    final prov = await statusAuth.getUserAuth();
                    log(name: '🔐login_page', '$prov?.uid.toString()');
                    log('recibo');
                  },
                  child: const Text('Verificar estado de inicio sesión')),
              ElevatedButton(
                  onPressed: () async {
                    log('consulto');
                    final status = await statusAuth.getUserStatus(
                        email: 'amolina5678@hotmail.com', pass: 'Alvaro1234');
                    log(
                        name: '✔️login_page',
                        status?.uid.toString() ??
                            'no se encuentra este usuario');
                    log('recibo');
                  },
                  child: const Text(
                      'Inicio de sesión con correo y password predef.')),
              ElevatedButton(
                  onPressed: () async {
                    log('Consulto');
                    final status = await statusAuth.getUserCreate(
                        email: 'amolina5678@hotmail.com', pass: 'Alvaro1234');
                    log(status?.uid.toString() ?? 'UID vacio.');
                  },
                  child: const Text('creamos una cuenta')),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Cerrar sesión')),
              ElevatedButton(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: Text('Inicio de sesion con Google')),
              ElevatedButton(
                  onPressed: () {
                    // signInWithFacebook();
                  },
                  child: Text('Inicio de sesion con Facebook'))
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
