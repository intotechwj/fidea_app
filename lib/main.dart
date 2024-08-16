import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fidea_app/views/pages/home_page.dart';
import 'package:fidea_app/text/apptext.dart';

const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: FirebaseOptionConfig.apiKey,
  appId: FirebaseOptionConfig.apiId,
  messagingSenderId: FirebaseOptionConfig.messagingSenderId,
  projectId: FirebaseOptionConfig.projectId,
  storageBucket: FirebaseOptionConfig.storageBucket,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: firebaseOptions);
    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              '${ErrorMessages.error}: $e',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
