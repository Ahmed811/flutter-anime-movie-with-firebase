import 'package:anim_movies/appConfig.dart';
import 'package:anim_movies/app_setting.dart';
import 'package:anim_movies/app_setting.dart';
import 'package:anim_movies/controller/controller.dart';
import 'package:anim_movies/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_setting.dart';

class DrawerApp extends StatelessWidget {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: '$DEVELOPER_EMAIL',
    query: encodeQueryParameters(
        <String, String>{'subject': 'this email about anime movies app'}),
  );
  DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              color: Colors.grey,
              alignment: Alignment.bottomCenter,
              child: Lottie.asset('assets/images/anime2.json', width: 275),
            ),
            ListTile(
              onTap: () {
                AppSetting().launchURL();
              },
              leading: Icon(
                Icons.rate_review_outlined,
                size: 30,
              ),
              title: Text(rateAppString),
            ),
            ListTile(
              onTap: () {
                launch(emailLaunchUri.toString());
              },
              leading: Icon(
                Icons.email,
                size: 30,
              ),
              title: Text(contactUsString),
            ),
            ListTile(
              leading: Icon(
                Provider.of<CustomTheme>(context, listen: false).isDarkTheme
                    ? Icons.wb_sunny
                    : Icons.dark_mode_outlined,
                size: 30,
              ),
              title: Text(
                  Provider.of<CustomTheme>(context, listen: false).isDarkTheme
                      ? 'الوضع النهاري'
                      : 'الوضع الليلي'),
              onTap: () {
                final customTheme =
                    Provider.of<CustomTheme>(context, listen: false)
                        .toggleTheme();
              },
            )
          ],
        ),
      ),
    );
  }
}
