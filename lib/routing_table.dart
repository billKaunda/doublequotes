import 'package:activity_list/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:doublequotes/tab_container_screen.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:settings_menu/settings_menu.dart';
import 'package:user_repository/user_repository.dart';
import 'package:monitoring/monitoring.dart';
import 'package:forgot_my_password/forgot_my_password.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_up/sign_up.dart';
import 'package:profile_menu/profile_menu.dart';
import 'package:quote_list/quote_list.dart';
import 'package:quote_details/quote_details.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required QuoteRepository quoteRepository,
  required ActivityRepository activityRepository,
  required RemoteValueService remoteValueService,

  // DynamicLinkService is no longer supported
  //required DynamicLinkService dynamicLinkService,
}) {
  return {
    //Wraps TabContainerScreen widget insider a CupertinoTabPage class
    // to achieve a nested navigation layout
    _PathConstants.tabContainerPath: (_) => CupertinoTabPage(
          child: const TabContainerScreen(),
          paths: [
            _PathConstants.quoteListPath,
            _PathConstants.activityListPath,
            _PathConstants.profileMenuPath,
            _PathConstants.settingsMenuPath,
          ],
        ),
    //Define two nested route homes
    _PathConstants.quoteListPath: (route) => MaterialPage(
          name: 'quotes-list',
          child: QuoteListScreen(
            quoteRepository: quoteRepository,
            userRepository: userRepository,
            onAuthenticationError: (context) => routerDelegate.push(
              _PathConstants.signInPath,
            ),
            onQuoteSelected: (id) {
              //QuoteDetailsPath may return a result; an updated Quote if the
              // user interacted with it while on that screen, e.g, by
              // favoriting it. You then return that Quote object to the
              // onQuoteSelected callback so that the QouteListScreen can
              // update it if sth changed.
              final navigation = routerDelegate.push<Quote?>(
                _PathConstants.quoteDetailsPath(
                  quoteId: id,
                ),
              );
              return navigation.result;
            },
            remoteValueService: remoteValueService,
          ),
        ),
    _PathConstants.activityListPath: (_) => MaterialPage(
          name: 'activity_list',
          child: ActivityListScreen(
            activityRepository: activityRepository,
            userRepository: userRepository,
            onAuthenticationError: (context) => routerDelegate.push(
              _PathConstants.signInPath,
            ),
          ),
        ),
    _PathConstants.profileMenuPath: (_) => MaterialPage(
          name: 'profile-menu',
          child: ProfileMenuScreen(
            quoteRepository: quoteRepository,
            userRepository: userRepository,
            activityRepository: activityRepository,
            onSignInTap: () => routerDelegate.push(
              _PathConstants.signInPath,
            ),
            onSignUpTap: () => routerDelegate.push(
              _PathConstants.signUpPath,
            ),
            onFollowersTap: () => routerDelegate.push(
              _PathConstants.followersListPath,
            ),
            onFollowingTap: () => routerDelegate.push(
              _PathConstants.followingListPath,
            ),
            onPublicFavoritesTap: () => routerDelegate.push(
              _PathConstants.publicFavoritesPath,
            ),
          ),
        ),
    _PathConstants.settingsMenuPath: (_) => MaterialPage(
          name: 'settings-menu',
          child: SettingsMenuScreen(
            userRepository: userRepository,
            quoteRepository: quoteRepository,
            onSignInTap: () => routerDelegate.push(
              _PathConstants.signInPath,
            ),
            onSignUpTap: () => routerDelegate.push(
              _PathConstants.signUpPath,
            ),
          ),
        ),
    //Define subsequent routes
    _PathConstants.quoteDetailsPath(): (info) => MaterialPage(
          name: 'quote-details',
          child: QuoteDetailsScreen(
            quoteRepository: quoteRepository,
            // info.pathParameters[_PathConstants.idPathParameter] is how
            // you extract a path parameter from a route. All path parameters
            // come to us as strings, that's the reason why parse it to an int.
            quoteId: int.tryParse(
                    info.pathParameters[_PathConstants.idPathParameter] ??
                        '') ??
                0,
            onAuthenticationError: () => routerDelegate.push(
              _PathConstants.signInPath,
            ),

            /*
            ///Dynamic Links is no longer supported
            shareableLinkGenerator: (quote) =>
                dynamicLinkService.generateDynamicLinkUrl(
              path: _PathConstants.quoteDetailsPath(
                quoteId: quote.id,
              ),
              TODO: 
              socialMetaTagParameters: SocialMetaTagParameters(
                title: quote.body,
                description: quote.author,
              ),
              */
          ),
        ),
    _PathConstants.signInPath: (_) => MaterialPage(
          name: 'sign-in',
          fullscreenDialog: true,
          child: Builder(
            builder: (context) => SignInScreen(
              userRepository: userRepository,
              onSignInSuccess: () => routerDelegate.pop(),
              onSignUpTap: () => routerDelegate.push(
                _PathConstants.signUpPath,
              ),
              onForgotMyPasswordTap: () => showDialog(
                context: context,
                builder: (context) {
                  return ForgotMyPasswordDialog(
                    userRepository: userRepository,
                    onCancelTap: () => routerDelegate.pop(),
                    onEmailRequestSuccess: () => routerDelegate.pop(),
                  );
                },
              ),
            ),
          ),
        ),
    _PathConstants.signUpPath: (_) => MaterialPage(
          name: 'sign-up',
          child: SignUpScreen(
            userRepository: userRepository,
            onSignUpSuccess: () => routerDelegate.pop(),
          ),
        ),
  };
}

//Define the app's paths
class _PathConstants {
  const _PathConstants._();

  static String get tabContainerPath => '/';

  static String get quoteListPath => '${tabContainerPath}quotes';

  static String get activityListPath => '${tabContainerPath}activity';

  static String get profileMenuPath => '${tabContainerPath}user';

  static String get settingsMenuPath => '${tabContainerPath}settings';

  static String get followersListPath => '$profileMenuPath/followers';

  static String get followingListPath => '$profileMenuPath/following';

  //TODO Implement a route to the favorites quotes screen
  static String get publicFavoritesPath => quoteListPath;

  static String get signInPath => '${tabContainerPath}sign-in';

  static String get signUpPath => '${tabContainerPath}sign-up';

  static String get idPathParameter => 'id';

  static String quoteDetailsPath({
    int? quoteId,
  }) =>
      '$quoteListPath/:$idPathParameter${quoteId != null ? '/$quoteId' : 0}';
}
