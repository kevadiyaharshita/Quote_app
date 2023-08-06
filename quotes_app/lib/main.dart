import 'package:flutter/material.dart';
import 'package:quotes_app/Views/screens/Details_page.dart';
import 'package:quotes_app/utils/MyRoutes.dart';
import 'package:quotes_app/utils/color_utils.dart';

import 'Views/screens/Home_Pade.dart';
import 'Views/screens/Splash_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: theme_1,
        ),
        initialRoute: MyRoutes.Splash_Screen,
        routes: {
          MyRoutes.home: (context) => const HomePage(),
          MyRoutes.detail_page: (context) => const Detail_Page(),
          MyRoutes.Splash_Screen: (context) => const Splash_Screen(),
        });
  }
}
