import 'package:anim_movies/app_drawer.dart';
import 'package:anim_movies/controller/controller.dart';
import 'package:anim_movies/screen/auth/authanticate.dart';
import 'package:anim_movies/screen/movie_show/movie_show.dart';
import 'package:anim_movies/unity_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adcolony_flutter/adcolony_flutter.dart';
import 'package:adcolony_flutter/banner.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../../appConfig.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AdColony.init(AdColonyOptions(ADCOLONYID, "0", zones));
    MyUnityAds().initAds();
    MyUnityAds().prepareFullScreenUnityAds();
    super.initState();
    // Provider.of<Controller>(context, listen: false).getDatabaseMovies();
  }

  listener(AdColonyAdListener? event, int? reward) async {
    print(event);
    if (event == AdColonyAdListener.onRequestFilled) {
      if (await AdColony.isLoaded()) {
        AdColony.show();
      }
    }
    if (event == AdColonyAdListener.onClosed) {
      //  print('ADCOLONY: closed');
    }
  }

  @override
  Widget build(BuildContext context) {
    //  Provider.of<Controller>(context).getDatabaseUrl();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قائمة الافلام",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Container(
              child: FutureBuilder(
                future: Provider.of<Controller>(context).getDatabaseMovies(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 9 / 12,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              var title = snapshot.data[index]['title'];
                              var img = snapshot.data[index]['img'];
                              var movieUrl = snapshot.data[index]['video_url'];
                              var movieDes = snapshot.data[index]['des'];
                              return InkWell(
                                onTap: () async {
                                  //   await AdColony.request(zones[0], listener);
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieShow(
                                              movieUrl: movieUrl,
                                              movieDes: movieDes,
                                              movieTitle: title,
                                              img: img)));
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          img,
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.black45,
                                                Colors.black38,
                                                Colors.white.withOpacity(.5)
                                              ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                          constraints: BoxConstraints.expand(),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                            maxLines: 2,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          child: BannerView(
                              listener, BannerSizes.banner, zones[1]),
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
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('لا يوجد اتصال بالانترنت!'),
                  Text(' تأكد من اتصالك بالانترنت ثم اعد تشغيل التطبيق')
                ],
              ),
            );
          }
        },
        child: const Text('hello'),
      ),
      drawer: DrawerApp(),
    );
  }
}
