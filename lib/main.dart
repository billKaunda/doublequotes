import 'dart:async';
import 'dart:isolate';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:routemaster/routemaster.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:activity_list/activity_list.dart';
import 'package:followers_list/followers_list.dart';
import 'package:following_list/following_list.dart';
import 'package:forgot_my_password/forgot_my_password.dart';
import 'package:profile_menu/profile_menu.dart';
import 'package:quote_list/quote_list.dart';
import 'package:settings_menu/settings_menu.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_up/sign_up.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:monitoring/monitoring.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:doublequotes/routing_table.dart';
import 'package:doublequotes/l10n/app_localizations.dart';
import 'package:doublequotes/screen_view_observer.dart';

void main() async {
  //Mark the ErrorReportingService as late and instantiate it so
  //that it doesn't instantiate before initializeMonitoringPackage()
  // call.
  late final errorReportingService = ErrorReportingService();

  //runZonedGuarded() method catches errors which are thrown when
  // running an asynchronous code.
  runZonedGuarded<Future<void>>(
    () async {
      //Ensure that Flutter is initialized. When initializing an app, the
      // app interacts with its native layers through async operation. This
      // happens via platform channels.
      WidgetsFlutterBinding.ensureInitialized();

      //Initialize Firebase core services, which are defined in the
      // monitoring.dart file.
      await initializeMonitoringPackage();

      //Crash the app to test it with Firebase's Crashlytics
      //final explicitCrash = ExplicitCrash();
      //explicitCrash.crashTheApp();

      //Initialize RemoteValueService and load feature flags from remote
      // config.
      final remoteValueService = RemoteValueService();
      await remoteValueService.load();

      //This lambda expression invokes the recordFlutterError method
      // with the FlutterErrorDetails passed in its argument which
      //holds the stacktrace, exception details, e.t.c.
      FlutterError.onError = errorReportingService.recordFlutterError;

      //This isolate function handles errors outside of Flutter context.
      // Add a listener to the current isolate for additional error
      // handling.
      Isolate.current.addErrorListener(
        RawReceivePort((pair) async {
          //Extract error and stacktrace from the error listener
          final List<dynamic> errorAndStackTrace = pair;
          await errorReportingService.recordError(
            errorAndStackTrace.first,
            errorAndStackTrace.last,
          );
        }).sendPort,
      );

      HttpOverrides.global = DQHttpOverrides();

      //Run the app with the initialized services.
      runApp(DoubleQuotes(
        remoteValueService: remoteValueService,
      ));
    },
    //Handle errors caught in the zone-errors that happen asynchronously.
    (error, stack) => errorReportingService.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
}

class DQHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class DoubleQuotes extends StatefulWidget {
  const DoubleQuotes({
    required this.remoteValueService,
    super.key,
  });
  final RemoteValueService remoteValueService;

  @override
  State<DoubleQuotes> createState() => _DoubleQuotesState();
}

class _DoubleQuotesState extends State<DoubleQuotes> {
  final _themeModeStorage = ThemeKeyValueStorage();
  final _typeaheadStorage = TypeaheadKeyValueStorage();
  final _quotesKeyValueStorage = QuotesKeyValueStorage();
  final _activityKeyValueStorage = ActivityKeyValueStorage();

  final _analyticsService = AnalyticsService();
  //final _dynamicLinkService = DynamicLinkService();

  late final SessionApiSection _remoteSessionApi;
  late final UsersApiSection _remoteUsersApi;
  late final TypeaheadApiSection _remoteTypeaheadApi;
  late final QuotesApiSection _remoteQuotesApi;
  late final ActivityApiSection _remoteActivityApi;
  late final UserRepository _userRepository;
  late final QuoteRepository _quoteRepository;
  late final ActivityRepository _activityRepository;
  late final RoutemasterDelegate _routerDelegate;

  final _wallpaperLightTheme = LightDoubleQuotesThemeData();
  final _wallpaperDarkTheme = DarkDoubleQuotesThemeData();
  final _defaultHighContrastDarkTheme = DefaultHighContrastDarkDQThemeData();
  final _defaultDarkTheme = DefaultDarkDQThemeData();
  final _defaultLightTheme = DefaultLightDQThemeData();
  final _defaultHighContrastLightTheme = DefaultHightContrastLightDQThemeData();

  @override
  void initState() {
    super.initState();

    _remoteSessionApi = SessionApiSection();

    _remoteTypeaheadApi = TypeaheadApiSection();

    _remoteQuotesApi = QuotesApiSection();

    _remoteActivityApi = ActivityApiSection();

    _remoteUsersApi = UsersApiSection(
      userSessionTokenSupplier: () => _userRepository.getToken(),
    );

    _userRepository = UserRepository(
      themeModeStorage: _themeModeStorage,
      typeaheadStorage: _typeaheadStorage,
      remoteSessionApi: _remoteSessionApi,
      remoteUsersApi: _remoteUsersApi,
      remoteTypeaheadApi: _remoteTypeaheadApi,
    );

    _quoteRepository = QuoteRepository(
      quotesKeyValueStorage: _quotesKeyValueStorage,
      remoteQuotesApi: _remoteQuotesApi,
    );

    _activityRepository = ActivityRepository(
      activityKeyValueStorage: _activityKeyValueStorage,
      remoteActivityApi: _remoteActivityApi,
    );

    _routerDelegate = RoutemasterDelegate(
      //Add observers to RoutemasterDelegate in order to track
      // navigation from one screen to another
      observers: [
        ScreenViewObserver(
          analyticsService: _analyticsService,
        ),
      ],
      routesBuilder: (context) => RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          quoteRepository: _quoteRepository,
          activityRepository: _activityRepository,
          remoteValueService: widget.remoteValueService,
        ),
      ),
    );

    /*
    //_openInitialDynamicLinkIfAny();
    
    ///Dynamic links is no longer supported
    _incomingDynamicLinkSubscription =
        _dynamicLinkService.onNewDynamicLinkPath().listen(
              _routerDelegate.push,
            );
    */
  }

  /*
  Future<void> _openInitialDynamicLinkIfAny() async {
    final path = await _dynamicLinkService.getInitialDynamicLinkPath();
    if (path != null) {
      _routerDelegate.push(path);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    // This StreamBuilder listens to three streams simultaneously
    return StreamBuilder3<ThemeSourcePreference, LanguagePreference,
        DarkModePreference>(
      streams: StreamTuple3(
        _userRepository.getThemeSourcePreference(),
        _userRepository.getLanguagePreference(),
        _userRepository.getDarkModePreference(),
      ),
      builder: (context, snapshots) {
        final themeSourcePreference = snapshots.snapshot1.data;
        //TODO Implement language selection from the user
        final languagePreference = snapshots.snapshot2.data;
        final darkModePreference = snapshots.snapshot3.data;

        Widget buildMaterialApp({
          required ThemeData theme,
          required ThemeData darkTheme,
          ThemeData? highContrastTheme,
          ThemeData? highContrastDarkTheme,
        }) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: true,
            routerDelegate: _routerDelegate,
            routeInformationParser: const RoutemasterParser(),
            theme: theme,
            darkTheme: darkTheme,
            highContrastTheme: highContrastTheme,
            highContrastDarkTheme: highContrastDarkTheme,
            themeMode: darkModePreference?.toThemeMode(),
            supportedLocales: const [
              Locale('en', ''),
              Locale('sw', 'KE'),
              Locale('sw', 'UG'),
              Locale('sw', 'TZ'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
              ComponentLibraryLocalizations.delegate,
              ActivityListLocalizations.delegate,
              FollowersListLocalizations.delegate,
              FollowingListLocalizations.delegate,
              ForgotMyPasswordLocalizations.delegate,
              ProfileMenuLocalizations.delegate,
              QuoteListLocalizations.delegate,
              SignInLocalizations.delegate,
              SignUpLocalizations.delegate,
            ],
          );
        }

        Widget buildThemeWidget() {
          if (themeSourcePreference == ThemeSourcePreference.fromWallpaper) {
            return FutureBuilder<List<ThemeData>>(
              future: Future.wait([
                _wallpaperLightTheme.themeData,
                _wallpaperDarkTheme.themeData,
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CenteredCircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const ExceptionIndicator(
                    title: "Error loading WallpaperTheme",
                    message: "Sorry, couldn't load theme from Wallpaper",
                  );
                } else if (snapshot.hasData) {
                  final themes = snapshot.data!;
                  return WallpaperDoubleQuotesTheme(
                    lightTheme: _wallpaperLightTheme,
                    darkTheme: _wallpaperDarkTheme,
                    child: buildMaterialApp(
                      theme: themes[0],
                      darkTheme: themes[1],
                    ),
                  );
                } else {
                  return const ExceptionIndicator(
                    title: "Error loading WallpaperTheme",
                    message: "Sorry, couldn't load theme from Wallpaper",
                  );
                }
              },
            );
          } else {
            return DefaultDoubleQuotesTheme(
              lightTheme: _defaultLightTheme,
              highContrastLightTheme: _defaultHighContrastLightTheme,
              darkTheme: _defaultDarkTheme,
              highContrastDarkTheme: _defaultHighContrastDarkTheme,
              child: buildMaterialApp(
                theme: _defaultLightTheme.materialThemeData,
                darkTheme: _defaultDarkTheme.materialThemeData,
                highContrastTheme:
                    _defaultHighContrastLightTheme.materialThemeData,
                highContrastDarkTheme:
                    _defaultHighContrastDarkTheme.materialThemeData,
              ),
            );
          }
        }

        return buildThemeWidget();
      },
    );
  }
}

extension on DarkModePreference {
  ThemeMode toThemeMode() {
    switch (this) {
      case DarkModePreference.accordingToSystemSettings:
        return ThemeMode.system;
      case DarkModePreference.highContrastDark:
        return ThemeMode.dark;
      case DarkModePreference.light:
        return ThemeMode.light;
      case DarkModePreference.highContrastLight:
        return ThemeMode.light;
      case DarkModePreference.dark:
        return ThemeMode.dark;
    }
  }
}
