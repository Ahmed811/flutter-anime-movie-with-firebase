import 'package:anim_movies/appConfig.dart';
import 'package:anim_movies/screen/home/home_screen.dart';
import 'package:anim_movies/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../error_snackbar.dart';

class SignIn extends StatefulWidget {
  final Function toggleAuthCallBack;
  SignIn({Key? key, required this.toggleAuthCallBack}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailInputController = TextEditingController();

  TextEditingController _passwordInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailInputController.dispose();
    _passwordInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleAuthCallBack();
              },
              icon: Icon(Icons.person),
              label: Text(signUpString))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/images/anime3.json', width: 175),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                loginPageString,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailInputController,
                        validator: (val) => val == null || !val.contains('@')
                            ? 'ادخل عنوان بريد الكتروني صالح'
                            : null,
                        decoration: InputDecoration(
                          hintText: enterEmailString,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordInputController,
                        validator: (val) => val == null || val.length < 6
                            ? 'ادخل رقم سري مكون من 6 احرف تقريبا'
                            : null,
                        decoration:
                            InputDecoration(hintText: enterPassowrdString),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final user = await AuthService()
                                  .signInUserWithEmailAndPassword(
                                      email: _emailInputController.text
                                          .toString()
                                          .trim(),
                                      password: _passwordInputController.text
                                          .toString()
                                          .trim());
                              if (user == null) {
                                ErrorMessage().createErrorMessage(
                                    context: context,
                                    message:
                                        'خطأ!البريد الاكتروني او الرقم السري غير صحيح');
                                print(AuthService().errorMessage);
                              }
                            }
                          },
                          child: Text(loginPageString))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
