import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

//Wrapper around [FirebaseRemoteConfig]
class RemoteValueService {
  static const _gridQuotesViewEnabledKey = 'grid_quotes_view_enabled';

  RemoteValueService({
    @visibleForTesting FirebaseRemoteConfig? remoteConfig,
  }) : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> load() async {
    try {
      await _remoteConfig.setDefaults({
        //Add default values for your parameters
        _gridQuotesViewEnabledKey: true,
      });

      //Fetch and activate the config that you'll set up on the Firebase
      // Remote Config console
      await _remoteConfig.fetchAndActivate();

      if (kDebugMode) {
        debugPrint('Remote Config values fetched and activated');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(
            'Failed to load Remote Config values: $e\nStack Trace: $stackTrace');
      }
    }
  }

  //Return the value of the feature flag you defined
  bool get isGridQuotesViewEnabled => _remoteConfig.getBool(
        _gridQuotesViewEnabledKey,
      );
}
