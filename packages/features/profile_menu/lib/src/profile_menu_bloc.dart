import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain_models/domain_models.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_menu_state.dart';

part 'profile_menu_event.dart';

class ProfileMenuBloc extends Bloc<ProfileMenuEvent, ProfileMenuState> {
  ProfileMenuBloc({
    required this.userRepository,
    required this.quoteRepository,
    required this.activityRepository,
  }) : super(
          const ProfileMenuLoaded(),
        ) {
    on<ProfileMenuStarted>(
      (_, emitter) async {
        debugPrint('Handling ProfileMenuStarted event');
        await emitter.onEach(
          Rx.combineLatest5<UserCredentials?, User?, ThemeSourcePreference,
                  DarkModePreference, LanguagePreference, ProfileMenuLoaded>(
              userRepository.createUserSession(),
              userRepository.getUser(),
              userRepository.getThemeSourcePreference(),
              userRepository.getDarkModePreference(),
              userRepository.getLanguagePreference(), (
            userCred,
            user,
            themeSourcePreference,
            darkModePreference,
            languagePreference,
          ) {
            //debugPrint('User fetched: ${user!.username}, ${userCred!.email}');
            return ProfileMenuLoaded(
              themeSourcePreference: themeSourcePreference,
              darkModePreference: darkModePreference,
              languagePreference: languagePreference,
              username: userCred?.username,
              picUrl: user?.picUrl,
              publicFavoritesCount: user?.publicFavoritesCount,
              followers: user?.followers,
              following: user?.following,
              isProUser: user?.isProUser ?? false,
              accountDetails: user?.accountDetails,
            );
          }),
          onData: (state) {
            debugPrint('ProfileMenuLoaded state emitted successfully');
            emitter(state);
          },
        );
      },
      /*
        transformer argument of the on() function gives you the ability
        to customize your events. Overriding the transformer argument
        is the factor you should consider when deciding to pick Blocs
        over Cubits for a specific screen.
        */
      transformer: (events, mapper) => events.flatMap(
        mapper,
      ),
    );

    on<ProfileMenuThemeSourcePrefChanged>((event, _) async {
      await userRepository.upsertThemeSourcePreference(
        event.themeSourcePreference,
      );

      add(const ProfileMenuStarted());
    });

    on<ProfileMenuDarkModePrefChanged>((event, _) async {
      await userRepository.upsertDarkModePreference(
        event.darkModePreference,
      );

      add(const ProfileMenuStarted());
    });

    on<ProfileMenuLanguagePrefChanged>((event, _) async {
      await userRepository.upsertLanguagePreference(
        event.languagePreference,
      );

      add(const ProfileMenuStarted());
    });

    on<ProfileMenuSignedOut>((_, emitter) async {
      final currentState = state as ProfileMenuLoaded;

      emitter(
        currentState.copyWith(isSignOutInProgress: true),
      );

      await userRepository.signOut();
      await quoteRepository.clearCache();
      await activityRepository.clearCache();
    });
  }

  final UserRepository userRepository;
  final QuoteRepository quoteRepository;
  final ActivityRepository activityRepository;
}
