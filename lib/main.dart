import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/DI/injector.dart';
import 'package:flutter_authentication/UI/providers/login/login_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'UI/pages/login/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I<LoginProvider>(),
        )
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: LoginPage()),
    );
  }
}
