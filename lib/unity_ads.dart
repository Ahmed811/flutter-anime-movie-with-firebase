import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import 'appConfig.dart';

class MyUnityAds {
  initAds() {
    UnityAds.init(
      gameId: unityId,
      testMode: unityTestMood,
      onComplete: () {
        //print('Initialization Complete')
      },
      onFailed: (error, message) {
        //print('Initialization Failed: $error $message')
      },
    );
  }

  prepareFullScreenUnityAds() async {
    await UnityAds.load(
      placementId: 'inter',
      onComplete: (placementId) {
        // print('Load Complete $placementId');
      },
      onFailed: (placementId, error, message) {
        // print('Load Failed $placementId: $error $message')
      },
    );
  }
}
