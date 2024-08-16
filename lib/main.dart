import 'package:fidea_app/text/apptext.dart';
import 'package:fidea_app/views/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: FirebaseOptionConfig.apiKey,
      appId: FirebaseOptionConfig.apiId,
      messagingSenderId: FirebaseOptionConfig.messagingSenderId,
      projectId: FirebaseOptionConfig.projectId,
      storageBucket: FirebaseOptionConfig.storageBucket,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
