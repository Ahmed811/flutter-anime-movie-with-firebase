import 'package:anim_movies/screen/auth/sign_in.dart';
import 'package:anim_movies/screen/auth/sign_up.dart';
import 'package:flutter/material.dart';

class Authanticate extends StatefulWidget {
  const Authanticate({Key? key}) : super(key: key);

  @override
  _AuthanticateState createState() => _AuthanticateState();
}

class _AuthanticateState extends State<Authanticate> {
  bool _isLSignUp = true;
  void toggleAuthCallBack() {
    setState(() {
      _isLSignUp = !_isLSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _isLSignUp
          ? SignIn(
              toggleAuthCallBack: toggleAuthCallBack,
            )
          : SignUp(
              toggleAuthCallBack: toggleAuthCallBack,
            ),
    );
  }
}
