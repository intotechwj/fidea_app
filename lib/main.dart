import 'package:fidea_app/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlatın
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAzp5xgNHbpVywphMTGcN6c9KsAE5js_m8',
      appId: '1:892223302158:android:f47a20082413fbe53bea5f',
      messagingSenderId: '892223302158',
      projectId: 'fidea-d859c',
      storageBucket: 'fidea-d859c.appspot.com',
    ),
  );

  // Tema dosyasını yükle
  /* final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;*/

  runApp(const MyApp(/*theme: theme*/));
}

class MyApp extends StatelessWidget {
  //final ThemeData theme;

  const MyApp({
    super.key,
    /*required this.theme*/
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: FlexThemeData.light(scheme: FlexScheme.ebonyClay),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.ebonyClay),
      themeMode: ThemeMode.system,
    );
  }
}
