import 'package:anim_movies/app_drawer.dart';
import 'package:anim_movies/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:adcolony_flutter/adcolony_flutter.dart';
import 'package:adcolony_flutter/banner.dart';

import '../../appConfig.dart';

class MovieShow extends StatefulWidget {
  final movieUrl, movieTitle, movieDes, img;
  const MovieShow(
      {Key? key, this.movieUrl, this.movieTitle, this.movieDes, this.img})
      : super(key: key);

  @override
  _MovieShowState createState() => _MovieShowState();
}

class _MovieShowState extends State<MovieShow> {
  late BetterPlayerController _betterPlayerController;

  playVideo(url) {
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, url,
            notificationConfiguration: BetterPlayerNotificationConfiguration(
              showNotification: true,
              title: widget.movieTitle,
              imageUrl: widget.img,
              activityName: "MainActivity",
            ));
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            allowedScreenSleep: false,
            placeholder: Image.network(
              widget.img,
              fit: BoxFit.cover,
            )),
        betterPlayerDataSource: betterPlayerDataSource);
    // _betterPlayerController.addEventsListener((event) async {
    //   if (event == BetterPlayerEventType.finished ||
    //       event == BetterPlayerEventType.pause) {
    //     await AdColony.request(zones[0], listener);
    //   }
    //   print("Better player event: ${event.betterPlayerEventType}");
    // });
    return _betterPlayerController;
  }

  @override
  void initState() {
    super.initState();
  }

  listener(AdColonyAdListener? event, int? reward) async {
    print(event);
    if (event == AdColonyAdListener.onRequestFilled) {
      if (await AdColony.isLoaded()) {
        AdColony.show();
      }
    }
    if (event == AdColonyAdListener.onClosed) {
      print('ADCOLONY: closed');
    }
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: DrawerApp(),
      body: SafeArea(
        child: SingleChildScrollView(
          // alignment: Alignment.topCenter,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: playVideo(widget.movieUrl),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Column(
                children: [
                  Text(
                    widget.movieTitle,
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.movieDes),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        await UnityAds.showVideoAd(
                          placementId: 'inter',
                          // onComplete: (placementId) => print(
                          //     'Video Ad $placementId completed'),
                          // onFailed: (placementId, error, message) =>
                          //     print(
                          //         'Video Ad $placementId failed: $error $message'),
                          // onStart: (placementId) =>
                          //     print('Video Ad $placementId started'),
                          // onClick: (placementId) =>
                          //     print('Video Ad $placementId click'),
                          // onSkipped: (placementId) =>
                          //     print('Video Ad $placementId skipped'),
                        );
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text(backToHomeString)),
                  TextButton.icon(
                      onPressed: () {
                        AppSetting().launchURL();
                      },
                      icon: Icon(Icons.rate_review_outlined),
                      label: Text(rateAppString)),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              UnityBannerAd(
                placementId: 'banner',
                // onLoad: (placementId) =>
                //     print('Banner loaded: $placementId'),
                // onClick: (placementId) =>
                //     print('Banner clicked: $placementId'),
                // onFailed: (placementId, error, message) => print(
                //     'Banner Ad $placementId failed: $error $message'),
              ),
              Container(
                child: BannerView(listener, BannerSizes.banner, zones[1]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
