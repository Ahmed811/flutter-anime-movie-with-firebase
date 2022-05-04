import 'package:anim_movies/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSetting {
  //rate app
  final _appUrl = "https://play.google.com/store/apps/details?id=$PACKAGE_NAME";
  void launchURL() async {
    if (!await launch(_appUrl)) throw 'Could not launch $_appUrl';
  }
}

//contact us

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
//
// final Uri emailLaunchUri = Uri(
//   scheme: 'mailto',
//   path: '$DEVELOPER_EMAIL',
//   query: encodeQueryParameters(
//       <String, String>{'subject': 'this email about anime movies app'}),
// );
