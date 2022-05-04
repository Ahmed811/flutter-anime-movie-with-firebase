import 'package:anim_movies/custom_theme.dart';
import 'package:anim_movies/screen/auth/authanticate.dart';
import 'package:anim_movies/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/controller.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final customTheme = Provider.of<CustomTheme>(context);
    return ChangeNotifierProvider<Controller>(
      create: (context) => Controller(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'anime movies',
        home: user != null ? HomeScreen() : Authanticate(),
        theme: customTheme.lightTheme,
        darkTheme: customTheme.darkTheme,
        themeMode: customTheme.currentTheme(),
      ),
    );
  }
}
